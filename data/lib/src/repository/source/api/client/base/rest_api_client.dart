import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:shared/shared.dart';

import '../../../../mapper/base/base_error_response_mapper.dart';
import '../../../../mapper/base/base_success_response_mapper.dart';
import '../../exception_mapper/dio_exception_mapper.dart';
import '../../middleware/base_interceptor.dart';
import '../base/api_client_default_settings.dart';
import '../base/dio_builder.dart';

enum RestMethod { get, post, put, patch, delete }

class RestApiClient {
  RestApiClient({
    this.baseUrl = '',
    this.interceptors = const [],
    this.errorResponseMapperType = ResponseMapperConstants.defaultErrorResponseMapperType,
    this.successResponseMapperType = ResponseMapperConstants.defaultSuccessResponseMapperType,
    this.connectTimeoutInMs = ServerTimeoutConstants.connectTimeoutInMs,
    this.sendTimeoutInMs = ServerTimeoutConstants.sendTimeoutInMs,
    this.receiveTimeoutInMs = ServerTimeoutConstants.receiveTimeoutInMs,
  }) : _dio = DioBuilder.createDio(
          options: BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: connectTimeoutInMs,
            sendTimeout: sendTimeoutInMs,
            receiveTimeout: receiveTimeoutInMs,
          ),
        ) {
    final sortedInterceptors = [
      ...ApiClientDefaultSetting.requiredInterceptors(_dio),
      ...interceptors,
    ].sortedByDescending((element) {
      return element is BaseInterceptor ? element.priority : -1;
    });

    _dio.interceptors.addAll(sortedInterceptors);
  }

  final SuccessResponseMapperType successResponseMapperType;
  final ErrorResponseMapperType errorResponseMapperType;
  final String baseUrl;
  final int? connectTimeoutInMs;
  final int? sendTimeoutInMs;
  final int? receiveTimeoutInMs;
  final List<Interceptor> interceptors;
  final Dio _dio;

  Future<T> request<T, D>({
    required RestMethod method,
    required String path,
    Map<String, dynamic>? queryParameters,
    // ignore: avoid-dynamic
    dynamic body,
    Decoder<D>? decoder,
    SuccessResponseMapperType? successResponseMapperType,
    ErrorResponseMapperType? errorResponseMapperType,
    BaseErrorResponseMapper? errorResponseMapper,
    Map<String, dynamic>? headers,
    String? contentType,
    ResponseType? responseType,
    int? sendTimeoutInMs,
    int? receiveTimeoutInMs,
  }) async {
    try {
      final response = await _requestByMethod(
        method: method,
        path: path.startsWith(baseUrl) ? path.substring(baseUrl.length) : path,
        queryParameters: queryParameters,
        body: body,
        options: Options(
          headers: headers,
          contentType: contentType,
          responseType: responseType,
          sendTimeout: sendTimeoutInMs,
          receiveTimeout: receiveTimeoutInMs,
        ),
      );

      return BaseSuccessResponseMapper<D, T>.fromType(
        successResponseMapperType ?? this.successResponseMapperType,
      ).map(response.data, decoder);
    } catch (error) {
      throw DioExceptionMapper(
        errorResponseMapper ??
            BaseErrorResponseMapper.fromType(
              errorResponseMapperType ?? this.errorResponseMapperType,
            ),
      ).map(error);
    }
  }

  Future<Response<T>> fetch<T>(RequestOptions requestOptions) {
    return _dio.fetch(requestOptions);
  }

  Future<Response> _requestByMethod({
    required RestMethod method,
    required String path,
    Map<String, dynamic>? queryParameters,
    // ignore: avoid-dynamic
    dynamic body,
    Options? options,
  }) {
    switch (method) {
      case RestMethod.get:
        return _dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
        );
      case RestMethod.post:
        return _dio.post(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
      case RestMethod.patch:
        return _dio.patch(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
      case RestMethod.put:
        return _dio.put(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
      case RestMethod.delete:
        return _dio.delete(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
    }
  }
}
