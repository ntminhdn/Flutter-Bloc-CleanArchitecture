import 'package:shared/shared.dart';

@Deprecated('outdated. Use class Result instead')
class ProcessState<T> {
  const ProcessState._({
    this.data,
    this.exception,
  }) : assert(data != null || exception != null);

  const ProcessState.success(T data) : this._(data: data);
  const ProcessState.failure(AppException exception) : this._(exception: exception);

  final T? data;
  final AppException? exception;

  @override
  int get hashCode => data.hashCode ^ exception.hashCode;

  bool get isFailure => exception != null;
  bool get isSuccess => data != null;

  ProcessState<T> onSuccess(Future<void> Function(T) action) {
    action(data!);

    return this;
  }

  ProcessState<T> onFailure(Future<void> Function(AppException) action) {
    action(exception!);

    return this;
  }

  ProcessState<T> copyWith({
    T? data,
    AppException? exception,
  }) {
    return ProcessState<T>._(
      data: data ?? this.data,
      exception: exception ?? this.exception,
    );
  }

  @override
  String toString() => 'ProcessState(data: $data, exception: $exception)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is ProcessState<T> && other.data == data && other.exception == exception;
  }
}
