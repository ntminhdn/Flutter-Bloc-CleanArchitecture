import 'app_exception.dart';

abstract class ExceptionMapper<T extends AppException> {
  T map(Object? exception);
}
