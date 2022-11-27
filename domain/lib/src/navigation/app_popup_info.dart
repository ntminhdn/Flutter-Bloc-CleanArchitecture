import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

part 'app_popup_info.freezed.dart';

/// dialog, bottomsheet
@freezed
class AppPopupInfo with _$AppPopupInfo {
  const factory AppPopupInfo.confirmDialog({
    @Default('') String message,
    Func0<void>? onPressed,
  }) = _ConfirmDialog;

  const factory AppPopupInfo.errorWithRetryDialog({
    @Default('') String message,
    Func0<void>? onRetryPressed,
  }) = _ErrorWithRetryDialog;

  const factory AppPopupInfo.requiredLoginDialog() = _RequiredLoginDialog;
}
