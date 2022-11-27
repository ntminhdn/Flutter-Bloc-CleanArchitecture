import 'package:freezed_annotation/freezed_annotation.dart';

import 'server_error_detail.dart';

part 'server_error.freezed.dart';

@freezed
class ServerError with _$ServerError {
  const factory ServerError({
    /// server-defined status code
    int? generalServerStatusCode,

    /// server-defined error id
    String? generalServerErrorId,

    /// server-defined message
    String? generalMessage,
    @Default(<ServerErrorDetail>[]) List<ServerErrorDetail> errors,
  }) = _ServerError;
}
