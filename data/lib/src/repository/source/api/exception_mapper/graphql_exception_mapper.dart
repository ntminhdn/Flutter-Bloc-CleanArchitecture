import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:shared/shared.dart';
import '../../../../../data.dart';

class GraphQLExceptionMapper extends ExceptionMapper<RemoteException> {
  GraphQLExceptionMapper(this._errorResponseMapper);

  final BaseErrorResponseMapper<dynamic> _errorResponseMapper;
  final _serverGraphQLErrorResponseMapper = const ServerGraphQLErrorMapper();

  @override
  RemoteException map(Object? exception) {
    if (exception is! OperationException) {
      return RemoteException(kind: RemoteExceptionKind.unknown, rootException: exception);
    }

    if (exception.linkException?.originalException is DioException) {
      final dioException = exception.linkException!.originalException as DioException;
      if (dioException.type == DioExceptionType.badResponse) {
        /// server-defined error
        ServerError? serverError;
        if (dioException.response?.data != null) {
          serverError = dioException.response!.data! is Map
              ? _errorResponseMapper.map(dioException.response!.data!)
              : ServerError(
                  generalMessage: dioException.response!.data! is String
                      ? dioException.response!.data! as String
                      : null,
                );
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
      final serverError = _serverGraphQLErrorResponseMapper.map(exception);

      return RemoteException(
        kind: RemoteExceptionKind.serverDefined,
        serverError: serverError,
      );
    }
  }
}
