import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

class ExceptionMessageMapper {
  const ExceptionMessageMapper();

  String map(AppException appException) {
    return switch (appException.appExceptionType) {
      AppExceptionType.remote => switch ((appException as RemoteException).kind) {
          RemoteExceptionKind.badCertificate => S.current.unknownException('UE-01'),
          RemoteExceptionKind.noInternet => S.current.noInternetException,
          RemoteExceptionKind.network => S.current.canNotConnectToHost,
          RemoteExceptionKind.serverDefined =>
            appException.generalServerMessage ?? S.current.unknownException('UE-02'),
          RemoteExceptionKind.serverUndefined =>
            appException.generalServerMessage ?? S.current.unknownException('UE-03'),
          RemoteExceptionKind.timeout => S.current.timeoutException,
          RemoteExceptionKind.cancellation => S.current.unknownException('UE-04'),
          RemoteExceptionKind.unknown => S.current.unknownException('UE-05'),
          RemoteExceptionKind.refreshTokenFailed => S.current.tokenExpired,
          RemoteExceptionKind.decodeError => S.current.unknownException('UE-06'),
          RemoteExceptionKind.invalidErrorResponse => S.current.unknownException('UE-07'),
          RemoteExceptionKind.invalidSuccessResponseMapperType =>
            S.current.unknownException('UE-08'),
          RemoteExceptionKind.invalidErrorResponseMapperType => S.current.unknownException('UE-09'),
        },
      AppExceptionType.parse => S.current.unknownException('UE-10'),
      AppExceptionType.uncaught => S.current.unknownException('UE-00'),
      AppExceptionType.validation => switch ((appException as ValidationException).kind) {
          ValidationExceptionKind.emptyEmail => S.current.emptyEmail,
          ValidationExceptionKind.invalidEmail => S.current.invalidEmail,
          ValidationExceptionKind.invalidPassword => S.current.invalidPassword,
          ValidationExceptionKind.invalidUserName => S.current.invalidUserName,
          ValidationExceptionKind.invalidPhoneNumber => S.current.invalidPhoneNumber,
          ValidationExceptionKind.invalidDateTime => S.current.invalidDateTime,
          ValidationExceptionKind.passwordsAreNotMatch => S.current.passwordsAreNotMatch,
        },
      AppExceptionType.remoteConfig => S.current.unknownException('UE-100'),
    };
  }
}
