import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../middleware/access_token_interceptor.dart';
import '../middleware/header_interceptor.dart';
import '../middleware/refresh_token_interceptor.dart';
import 'base/rest_api_client.dart';

@LazySingleton()
class AuthAppServerApiClient extends RestApiClient {
  AuthAppServerApiClient(
    HeaderInterceptor _headerInterceptor,
    AccessTokenInterceptor _accessTokenInterceptor,
    RefreshTokenInterceptor _refreshTokenInterceptor,
  ) : super(baseUrl: UrlConstants.appApiBaseUrl, interceptors: [
          _headerInterceptor,
          _accessTokenInterceptor,
          _refreshTokenInterceptor,
        ]);
}
