import 'package:shared/shared.dart';

import '../../../../../../data.dart';

enum ErrorResponseMapperType {
  jsonObject,
  jsonArray,
  line,
  twitter,
  goong,
  firebaseStorage,
}

abstract class BaseErrorResponseMapper<T> {
  const BaseErrorResponseMapper();

  factory BaseErrorResponseMapper.fromType(ErrorResponseMapperType type) {
    switch (type) {
      case ErrorResponseMapperType.jsonObject:
        return JsonObjectErrorResponseMapper() as BaseErrorResponseMapper<T>;
      case ErrorResponseMapperType.jsonArray:
        return JsonArrayErrorResponseMapper() as BaseErrorResponseMapper<T>;
      case ErrorResponseMapperType.line:
        return LineErrorResponseMapper() as BaseErrorResponseMapper<T>;
      case ErrorResponseMapperType.twitter:
        return TwitterErrorResponseMapper() as BaseErrorResponseMapper<T>;
      case ErrorResponseMapperType.goong:
        return GoongErrorResponseMapper() as BaseErrorResponseMapper<T>;
      case ErrorResponseMapperType.firebaseStorage:
        return FirebaseStorageErrorResponseMapper() as BaseErrorResponseMapper<T>;
    }
  }

  ServerError map(dynamic errorResponse) {
    try {
      if (errorResponse is! T) {
        throw RemoteException(
          kind: RemoteExceptionKind.invalidErrorResponseMapperType,
          rootException: 'Response is not $T',
        );
      }

      final serverError = mapToServerError(errorResponse);

      if (serverError.isDefault) {
        throw RemoteException(
          kind: RemoteExceptionKind.invalidErrorResponse,
          rootException: '$errorResponse is invalid, $serverError is empty',
        );
      }

      return serverError;
    } on RemoteException catch (_) {
      rethrow;
    } catch (e) {
      throw RemoteException(kind: RemoteExceptionKind.decodeError, rootException: e);
    }
  }

  ServerError mapToServerError(T? errorResponse);
}
