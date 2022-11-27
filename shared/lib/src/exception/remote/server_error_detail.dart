import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_error_detail.freezed.dart';

@freezed
class ServerErrorDetail with _$ServerErrorDetail {
  const factory ServerErrorDetail({
    @Default('') String detail,
    @Default('') String path,

    /// server-defined error code
    @Default('') String serverErrorId,

    /// server-defined status code
    @Default(-1) int serverStatusCode,

    /// server-defined message
    @Default('') String message,

    /// server-defined field
    @Default('') String field,
  }) = _ServerErrorDetail;
}
