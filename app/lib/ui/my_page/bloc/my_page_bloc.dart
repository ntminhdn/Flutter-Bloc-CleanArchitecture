import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'my_page.dart';

@Injectable()
class MyPageBloc extends BaseBloc<MyPageEvent, MyPageState> {
  MyPageBloc(this._logoutUseCase) : super(const MyPageState()) {
    on<LogoutButtonPressed>(
      _onLogoutButtonPressed,
      transformer: log(),
    );
  }

  final LogoutUseCase _logoutUseCase;

  FutureOr<void> _onLogoutButtonPressed(
    LogoutButtonPressed event,
    Emitter<MyPageState> emit,
  ) async {
    return runBlocCatching(
      action: () async {
        await _logoutUseCase.execute(const LogoutInput());
      },
    );
  }
}
