import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared/shared.dart';

import '../../../mapper/base/base_error_response_mapper.dart';
import '../../../mapper/base_error_response_mapper/server_graphql_error_mapper.dart';
import 'dio_exception_mapper.dart';

class GraphQLExceptionMapper extends ExceptionMapper<RemoteException> {
  GraphQLExceptionMapper(this._errorResponseMapper);

  final BaseErrorResponseMapper _errorResponseMapper;
  final _serverGraphQLErrorResponseMapper = const ServerGraphQLErrorMapper();

  @override
  RemoteException map(Object? exception) {
    if (exception is! OperationException) {
      return RemoteException(kind: RemoteExceptionKind.unknown, rootException: exception);
    }

    if (exception.linkException?.originalException is DioError) {
      final dioException = exception.linkException!.originalException as DioError;
      if (dioException.type == DioErrorType.response) {
        /// server-defined error
        ServerError? serverError;
        if (dioException.response?.data != null) {
          serverError = dioException.response!.data! is Map
              ? _errorResponseMapper.mapToEntity(dioException.response!.data!)
              : ServerError(generalMessage: dioException.response!.data!);
        }

        return RemoteException(
          kind: RemoteExceptionKind.serverUndefined,
          serverError: serverError,
        );
      } else {
        return DioExceptionMapper(_errorResponseMapper)
            .map(exception.linkException?.originalException);
      }
    } else {
      final serverError = _serverGraphQLErrorResponseMapper.mapToEntity(exception);

      return RemoteException(
        kind: RemoteExceptionKind.serverDefined,
        serverError: serverError,
      );
    }
  }
}
