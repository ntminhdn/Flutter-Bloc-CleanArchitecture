import '../../shared.dart';

mixin LogMixin on Object {
  void logD(String message, {DateTime? time}) {
    Log.d(message, name: runtimeType.toString(), time: time);
  }

  void logE(
    Object? errorMessage, {
    Object? clazz,
    Object? errorObject,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    Log.e(
      errorMessage,
      name: runtimeType.toString(),
      errorObject: errorObject,
      stackTrace: stackTrace,
      time: time,
    );
  }
}
