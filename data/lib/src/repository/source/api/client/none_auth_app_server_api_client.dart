import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../middleware/header_interceptor.dart';
import 'base/rest_api_client.dart';

@LazySingleton()
class NoneAuthAppServerApiClient extends RestApiClient {
  NoneAuthAppServerApiClient(HeaderInterceptor _headerInterceptor)
      : super(baseUrl: UrlConstants.appApiBaseUrl, interceptors: [
          _headerInterceptor,
        ]);
}
