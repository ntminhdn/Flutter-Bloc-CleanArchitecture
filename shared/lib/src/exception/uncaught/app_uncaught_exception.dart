import '../../../shared.dart';

class AppUncaughtException extends AppException {
  const AppUncaughtException(this.rootError) : super(AppExceptionType.uncaught);

  final Object? rootError;

  @override
  String toString() {
    return 'rootError: ${rootError?.toString()}';
  }
}
