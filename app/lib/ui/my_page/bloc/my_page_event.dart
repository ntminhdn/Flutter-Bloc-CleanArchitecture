import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'my_page_event.freezed.dart';

abstract class MyPageEvent extends BaseBlocEvent {
  const MyPageEvent();
}

@freezed
class MyPagePageInitiated extends MyPageEvent with _$MyPagePageInitiated {
  const factory MyPagePageInitiated({
    required int id,
  }) = _MyPagePageInitiated;
}

@freezed
class LogoutButtonPressed extends MyPageEvent with _$LogoutButtonPressed {
  const factory LogoutButtonPressed() = _LogoutButtonPressed;
}
