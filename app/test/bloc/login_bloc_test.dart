// ignore_for_file: missing_run_bloc_catching
import 'package:app/app.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../fake_data.dart';

class MockAppNavigator extends Mock implements AppNavigator {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockFakeLoginUseCase extends Mock implements FakeLoginUseCase {}

class MockCommonBloc extends Mock implements CommonBloc {}

class MockExceptionMessageMapper extends Mock implements ExceptionMessageMapper {}

void main() {
  group('LoginBloc', () {
    late LoginBloc bloc;
    final _loginUseCase = MockLoginUseCase();
    final _fakeLoginUseCase = MockFakeLoginUseCase();
    final _navigator = MockAppNavigator();
    final _commonBloc = MockCommonBloc();
    final _exceptionMessageMapper = MockExceptionMessageMapper();

    setUp(() {
      bloc = LoginBloc(_loginUseCase, _fakeLoginUseCase);
      bloc.navigator = _navigator;
      bloc.commonBloc = _commonBloc;
      bloc.exceptionMessageMapper = _exceptionMessageMapper;
    });

    test('correct initialState', () {
      expect(bloc.state, const LoginState());
    });

    blocTest<LoginBloc, LoginState>(
      'login successfully',
      setUp: () {
        when(() => _navigator.replace(const AppRouteInfo.main()))
            .thenAnswer((_) => Future.value(true));

        when(() =>
                _loginUseCase.execute(const LoginInput(email: inputEmail, password: inputPassword)))
            .thenAnswer((_) => Future.value(const LoginOutput()));
      },
      build: () => bloc,
      act: (bloc) {
        bloc.add(const EmailTextFieldChanged(email: inputEmail));
        bloc.add(const PasswordTextFieldChanged(password: inputPassword));
        bloc.add(const LoginButtonPressed());
      },
      expect: () => <LoginState>[
        const LoginState(email: inputEmail),
        const LoginState(email: inputEmail, password: inputPassword, isLoginButtonEnabled: true),
      ],
      verify: (_) {
        verify(() => _navigator.replace(const AppRouteInfo.main())).called(1);
      },
    );

    tearDown(() {
      bloc.close();
    });

    blocTest<LoginBloc, LoginState>(
      'login failed',
      setUp: () {
        when(() =>
                _loginUseCase.execute(const LoginInput(email: inputEmail, password: inputPassword)))
            .thenThrow(validationError);
        when(() => _exceptionMessageMapper.map(validationError))
            .thenReturn(validationError.toString());
      },
      build: () => bloc,
      act: (bloc) {
        bloc.add(const EmailTextFieldChanged(email: inputEmail));
        bloc.add(const PasswordTextFieldChanged(password: inputPassword));
        bloc.add(const LoginButtonPressed());
      },
      expect: () => <LoginState>[
        const LoginState(email: inputEmail),
        const LoginState(email: inputEmail, password: inputPassword, isLoginButtonEnabled: true),
        LoginState(
          email: inputEmail,
          password: inputPassword,
          isLoginButtonEnabled: true,
          onPageError: validationError.toString(),
        ),
      ],
      verify: (_) {
        verifyNever(() => _navigator.replace(const AppRouteInfo.main()));
      },
    );

    tearDown(() {
      bloc.close();
    });
  });
}
