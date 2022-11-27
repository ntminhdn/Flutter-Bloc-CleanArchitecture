import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState extends BaseBlocState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isLoginButtonEnabled,
    @Default(false) bool obscureText,
    @Default('') String onPageError,
    @Default(false) bool showLoginButtonLoading,
  }) = _LoginState;
}
