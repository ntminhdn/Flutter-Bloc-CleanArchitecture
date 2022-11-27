import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import 'base/rest_api_client.dart';

@LazySingleton()
class MockApiClient extends RestApiClient {
  MockApiClient() : super(baseUrl: UrlConstants.mockApiBaseUrl);
}
