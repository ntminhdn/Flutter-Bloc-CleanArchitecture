import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared/shared.dart';

import '../../../mapper/base/base_error_response_mapper.dart';

class DioExceptionMapper extends ExceptionMapper<RemoteException> {
  DioExceptionMapper(this._errorResponseMapper);

  final BaseErrorResponseMapper _errorResponseMapper;

  @override
  RemoteException map(Object? exception) {
    if (exception is DioException) {
      switch (exception.type) {
        case DioExceptionType.cancel:
          return const RemoteException(kind: RemoteExceptionKind.cancellation);
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return RemoteException(
            kind: RemoteExceptionKind.timeout,
            rootException: exception,
          );
        case DioExceptionType.badResponse:
          final httpErrorCode = exception.response?.statusCode ?? -1;

          /// server-defined error
          if (exception.response?.data != null) {
            final serverError = exception.response!.data! is Map
                ? _errorResponseMapper.mapToEntity(exception.response!.data!)
                : ServerError(generalMessage: exception.response!.data!);

            return RemoteException(
              kind: RemoteExceptionKind.serverDefined,
              httpErrorCode: httpErrorCode,
              serverError: serverError,
            );
          }

          return RemoteException(
            kind: RemoteExceptionKind.serverUndefined,
            httpErrorCode: httpErrorCode,
            rootException: exception,
          );
        case DioExceptionType.badCertificate:
          return RemoteException(
            kind: RemoteExceptionKind.badCertificate,
            rootException: exception,
          );
        case DioExceptionType.connectionError:
          return RemoteException(kind: RemoteExceptionKind.network, rootException: exception);
        case DioExceptionType.unknown:
          if (exception is SocketException) {
            return RemoteException(kind: RemoteExceptionKind.network, rootException: exception);
          }

          if (exception.error is RemoteException) {
            return exception.error as RemoteException;
          }
      }
    }

    return RemoteException(kind: RemoteExceptionKind.unknown, rootException: exception);
  }
}
