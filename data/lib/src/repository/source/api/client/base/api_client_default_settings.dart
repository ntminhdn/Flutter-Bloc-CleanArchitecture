import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../../../data.dart';

class ApiClientDefaultSetting {
  const ApiClientDefaultSetting._();

  static const defaultErrorResponseMapperType = ErrorResponseMapperType.jsonObject;
  static const defaultSuccessResponseMapperType = SuccessResponseMapperType.dataJsonObject;

  // required interceptors
  static List<Interceptor> requiredInterceptors(Dio dio) => [
        if (kDebugMode) CustomLogInterceptor(),
        ConnectivityInterceptor(),
        RetryOnErrorInterceptor(dio),
      ];
}
