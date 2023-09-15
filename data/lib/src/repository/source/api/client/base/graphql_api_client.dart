import 'package:cookie_jar/cookie_jar.dart';
import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:gql/ast.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared/shared.dart';
import '../../../../../../data.dart';

enum GraphQLMethod { query, mutate }

class GraphQLApiClient {
  GraphQLApiClient({
    this.baseUrl = '',
    this.interceptors = const [],
    this.errorResponseMapperType = ApiClientDefaultSetting.defaultErrorResponseMapperType,
    this.connectTimeout = ServerTimeoutConstants.connectTimeout,
    this.sendTimeout = ServerTimeoutConstants.sendTimeout,
    this.receiveTimeout = ServerTimeoutConstants.receiveTimeout,
  }) : _graphQLClient = ValueNotifier<GraphQLClient>(
          GraphQLClient(
            cache: GraphQLCache(),
            link: DioLink(
              UrlConstants.appApiBaseUrl,
              client: DioBuilder.createDio(
                options: BaseOptions(
                  baseUrl: baseUrl,
                  connectTimeout: connectTimeout,
                  sendTimeout: sendTimeout,
                  receiveTimeout: receiveTimeout,
                ),
              ),
            ),
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

  final ErrorResponseMapperType errorResponseMapperType;
  final String baseUrl;
  final Duration? connectTimeout;
  final Duration? sendTimeout;
  final Duration? receiveTimeout;
  final List<Interceptor> interceptors;
  final ValueNotifier<GraphQLClient> _graphQLClient;

  Dio get _dio => (_graphQLClient.value.link as DioLink).client;

  Future<T> request<T>({
    required GraphQLMethod method,
    required DocumentNode document,
    Map<String, dynamic> variables = const {},
    FetchPolicy? fetchPolicy = FetchPolicy.noCache,
    ErrorResponseMapperType? errorResponseMapperType,
    Decoder<T>? decoder,
  }) async {
    final response = await _requestByMethod(
      method: method,
      document: document,
      fetchPolicy: fetchPolicy,
      variables: variables,
    );

    if (response.exception != null) {
      throw GraphQLExceptionMapper(
        BaseErrorResponseMapper.fromType(
          errorResponseMapperType ?? this.errorResponseMapperType,
        ),
      ).map(response.exception);
    }

    return BaseSuccessResponseMapper<T, T>.fromType(SuccessResponseMapperType.jsonObject)
        .map(response: response.data, decoder: decoder);
  }

  Future<QueryResult> _requestByMethod({
    required GraphQLMethod method,
    required DocumentNode document,
    required FetchPolicy? fetchPolicy,
    required Map<String, dynamic> variables,
  }) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    _dio.interceptors.add(
      CookieManager(
        PersistCookieJar(
          storage: FileStorage('${appDocDir.path}/.cookies/'),
        ),
      ),
    );

    switch (method) {
      case GraphQLMethod.query:
        return _graphQLClient.value.query(QueryOptions(
          document: document,
          variables: variables,
          fetchPolicy: fetchPolicy,
        ));
      case GraphQLMethod.mutate:
        return _graphQLClient.value.mutate(MutationOptions(
          document: document,
          variables: variables,
          fetchPolicy: fetchPolicy,
        ));
    }
  }
}
