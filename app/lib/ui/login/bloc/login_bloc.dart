import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'login.dart';

@Injectable()
class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc(this._loginUseCase, this._fakeLoginUseCase) : super(const LoginState()) {
    on<EmailTextFieldChanged>(
      _onEmailTextFieldChanged,
      transformer: distinct(),
    );

    on<PasswordTextFieldChanged>(
      _onPasswordTextFieldChanged,
      transformer: distinct(),
    );

    on<LoginButtonPressed>(
      _onLoginButtonPressed,
      transformer: log(),
    );

    on<EyeIconPressed>(
      _onEyeIconPressed,
      transformer: log(),
    );

    on<FakeLoginButtonPressed>(
      _onFakeLoginButtonPressed,
      transformer: log(),
    );
  }

  final LoginUseCase _loginUseCase;
  final FakeLoginUseCase _fakeLoginUseCase;

  bool _isLoginButtonEnabled(String email, String password) {
    return email.isNotEmpty && password.isNotEmpty;
  }

  void _onEmailTextFieldChanged(EmailTextFieldChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      email: event.email,
      isLoginButtonEnabled: _isLoginButtonEnabled(event.email, state.password),
      onPageError: '',
    ));
  }

  void _onPasswordTextFieldChanged(PasswordTextFieldChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      password: event.password,
      isLoginButtonEnabled: _isLoginButtonEnabled(state.email, event.password),
      onPageError: '',
    ));
  }

  FutureOr<void> _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) {
    return runBlocCatching(
      action: () async {
        await _loginUseCase.execute(LoginInput(email: state.email, password: state.password));
        await navigator.replace(const AppRouteInfo.main());
      },
      handleError: false,
      doOnError: (e) async {
        emit(state.copyWith(onPageError: exceptionMessageMapper.map(e)));
      },
    );
  }

  FutureOr<void> _onFakeLoginButtonPressed(
    FakeLoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    return runBlocCatching(
      action: () async {
        await _fakeLoginUseCase.execute(const FakeLoginInput());
      },
    );
  }

  void _onEyeIconPressed(EyeIconPressed event, Emitter<LoginState> emit) {
    emit(state.copyWith(obscureText: !state.obscureText));
  }
}
