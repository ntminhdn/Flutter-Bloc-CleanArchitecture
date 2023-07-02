import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app.dart';

part 'register_account_state.freezed.dart';

@freezed
class RegisterAccountState extends BaseBlocState with _$RegisterAccountState {
  const RegisterAccountState._();

  const factory RegisterAccountState({
    @Default('') String id,
  }) = _RegisterAccountState;
}
