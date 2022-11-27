import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../middleware/connectivity_interceptor.dart';
import '../../middleware/custom_log_interceptor.dart';
import '../../middleware/retry_on_error_interceptor.dart';

class ApiClientDefaultSetting {
  const ApiClientDefaultSetting._();

  // required interceptors
  static List<Interceptor> requiredInterceptors(Dio dio) => [
        if (kDebugMode) CustomLogInterceptor(),
        ConnectivityInterceptor(),
        RetryOnErrorInterceptor(dio),
      ];
}
