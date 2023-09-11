import 'package:freezed_annotation/freezed_annotation.dart';

import 'server_error_detail.dart';

part 'server_error.freezed.dart';

@freezed
class ServerError with _$ServerError {
  const ServerError._();
  const factory ServerError({
    /// server-defined status code
    int? generalServerStatusCode,

    /// server-defined error id
    String? generalServerErrorId,

    /// server-defined message
    String? generalMessage,
    @Default(ServerError.defaultErrors) List<ServerErrorDetail> errors,
  }) = _ServerError;

  static const defaultGeneralServerStatusCode = -1;
  static const defaultGeneralServerErrorId = '';
  static const defaultGeneralMessage = '';
  static const defaultErrors = <ServerErrorDetail>[];

  bool get isDefault =>
      this == const ServerError() || this == const ServerError(errors: [ServerErrorDetail()]);
}
