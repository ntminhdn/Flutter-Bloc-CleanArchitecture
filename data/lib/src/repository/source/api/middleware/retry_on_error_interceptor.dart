import 'package:dio/dio.dart';
import 'package:shared/shared.dart';

import 'base_interceptor.dart';

class RetryOnErrorInterceptor extends BaseInterceptor {
  RetryOnErrorInterceptor(this.dio);

  final Dio dio;
  int _retries = RetryOnErrorConstants.retries;

  static const _retryHeaderKey = 'isRetry';

  @override
  int get priority => BaseInterceptor.retryOnErrorPriority;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.headers.containsKey(_retryHeaderKey)) {
      _retries = RetryOnErrorConstants.retries;
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_retries > 0 && shouldRetry(err)) {
      await Future.delayed(RetryOnErrorConstants.retryInterval);
      _retries--;
      try {
        return await dio
            .fetch(err.requestOptions..headers[_retryHeaderKey] = true)
            .then((value) => handler.resolve(value));
      } catch (e) {
        return super.onError(err, handler);
      }
    }

    return super.onError(err, handler);
  }

  bool shouldRetry(DioError error) =>
      error.type != DioErrorType.cancel && error.type != DioErrorType.response;
}
