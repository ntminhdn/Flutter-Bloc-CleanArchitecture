import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import 'base/rest_api_client.dart';

@LazySingleton()
class RandomUserApiClient extends RestApiClient {
  RandomUserApiClient() : super(baseUrl: UrlConstants.randomUserBaseUrl);
}
