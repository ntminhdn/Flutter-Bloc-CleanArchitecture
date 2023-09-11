import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data.dart';

@LazySingleton()
class RawApiClient extends RestApiClient {
  RawApiClient()
      : super(
          dio: DioBuilder.createDio(
            options: BaseOptions(baseUrl: ''),
          ),
        );
}
