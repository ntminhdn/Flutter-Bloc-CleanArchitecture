import 'package:dio/dio.dart';

abstract class BaseInterceptor extends InterceptorsWrapper {
  static const basicAuthPriority = 40;
  static const connectivityPriority = 99; // add second
  static const customLogPriority = 1; // add last
  static const headerPriority = 19;
  static const accessTokenPriority = 20;
  static const refreshTokenPriority = 30;
  static const retryOnErrorPriority = 100; // add first

  /// higher, add first
  /// lower, add last
  int get priority;
}
