import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';

@Injectable()
class MainBloc extends BaseBloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<MainPageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );
  }

  FutureOr<void> _onMainPageInitiated(MainPageInitiated event, Emitter<MainState> emit) {
    // Xin hãy ghi nhớ đặt tên Event theo convention:
    // <Tên Widget><Verb ở dạng Quá khứ>. VD: LoginButtonPressed, EmailTextFieldChanged, HomePageRefreshed
  }
}
