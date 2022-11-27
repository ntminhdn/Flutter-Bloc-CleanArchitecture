import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../middleware/access_token_interceptor.dart';
import '../middleware/header_interceptor.dart';
import 'base/rest_api_client.dart';

@LazySingleton()
class RefreshTokenApiClient extends RestApiClient {
  RefreshTokenApiClient(
    HeaderInterceptor _headerInterceptor,
    AccessTokenInterceptor _accessTokenInterceptor,
  ) : super(
          baseUrl: UrlConstants.appApiBaseUrl,
          interceptors: [
            _headerInterceptor,
            _accessTokenInterceptor,
          ],
        );
}
