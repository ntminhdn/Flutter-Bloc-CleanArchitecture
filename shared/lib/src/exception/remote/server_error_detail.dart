import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_error_detail.freezed.dart';

@freezed
class ServerErrorDetail with _$ServerErrorDetail {
  const factory ServerErrorDetail({
    String? detail,
    String? path,

    /// server-defined error code
    String? serverErrorId,

    /// server-defined status code
    int? serverStatusCode,

    /// server-defined message
    String? message,

    /// server-defined field
    String? field,
  }) = _ServerErrorDetail;
}
