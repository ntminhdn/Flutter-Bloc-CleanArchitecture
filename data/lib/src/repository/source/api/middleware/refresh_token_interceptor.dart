import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';
import 'package:tuple/tuple.dart';

import '../../preference/app_preferences.dart';
import '../client/none_auth_app_server_api_client.dart';
import '../refresh_token_api_service.dart';
import 'base_interceptor.dart';

@Injectable()
class RefreshTokenInterceptor extends BaseInterceptor {
  RefreshTokenInterceptor(
    this.appPreferences,
    this.refreshTokenService,
    this._noneAuthAppServerApiClient,
  );

  final AppPreferences appPreferences;
  final RefreshTokenApiService refreshTokenService;
  final NoneAuthAppServerApiClient _noneAuthAppServerApiClient;

  var _isRefreshing = false;
  final _queue = Queue<Tuple2<RequestOptions, ErrorInterceptorHandler>>();

  @override
  int get priority => BaseInterceptor.refreshTokenPriority;

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      final options = err.response!.requestOptions;
      _onExpiredToken(options, handler);
    } else {
      handler.next(err);
    }
  }

  void _putAccessToken(Map<String, dynamic> headers, String accessToken) {
    headers[ServerRequestResponseConstants.basicAuthorization] =
        '${ServerRequestResponseConstants.bearer} $accessToken';
  }

  void _onExpiredToken(RequestOptions options, ErrorInterceptorHandler handler) {
    _queue.addLast(Tuple2(options, handler));
    if (!_isRefreshing) {
      _isRefreshing = true;
      _refreshToken()
          .then(_onRefreshTokenSuccess)
          .catchError(_onRefreshTokenError)
          .whenComplete(() {
        _isRefreshing = false;
        _queue.clear();
      });
    }
  }

  Future<String> _refreshToken() async {
    _isRefreshing = true;
    final refreshToken = await appPreferences.refreshToken;
    final refreshTokenResponse = await refreshTokenService.refreshToken(refreshToken);
    await Future.wait(
      [
        appPreferences.saveAccessToken(refreshTokenResponse.data?.accessToken ?? ''),
      ],
    );

    return refreshTokenResponse.data?.accessToken ?? '';
  }

  Future<void> _onRefreshTokenSuccess(String newToken) async {
    await Future.wait(_queue.map(
      (requestInfo) => _requestWithNewToken(requestInfo.item1, requestInfo.item2, newToken),
    ));
  }

  void _onRefreshTokenError(Object? error) {
    _queue.forEach((element) {
      final options = element.item1;
      final handler = element.item2;
      handler.next(DioError(requestOptions: options, error: error));
    });
  }

  Future<void> _requestWithNewToken(
    RequestOptions options,
    ErrorInterceptorHandler handler,
    String newAccessToken,
  ) {
    _putAccessToken(options.headers, newAccessToken);

    return _noneAuthAppServerApiClient
        .fetch(options)
        .then((response) => handler.resolve(response))
        .catchError((e) => handler.next(DioError(requestOptions: options, error: e)));
  }
}
