import 'package:dio/dio.dart';
import 'package:shared/shared.dart';

class DioBuilder {
  const DioBuilder._();

  static Dio createDio({
    BaseOptions? options,
  }) {
    return Dio(
      BaseOptions(
        connectTimeout: options?.connectTimeout ?? ServerTimeoutConstants.connectTimeoutInMs,
        receiveTimeout: options?.receiveTimeout ?? ServerTimeoutConstants.receiveTimeoutInMs,
        sendTimeout: options?.sendTimeout ?? ServerTimeoutConstants.sendTimeoutInMs,
        baseUrl: options?.baseUrl ?? UrlConstants.appApiBaseUrl,
      ),
    );
  }
}
