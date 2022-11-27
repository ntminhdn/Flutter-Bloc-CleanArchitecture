import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';

@Injectable()
class MyPageBloc extends BaseBloc<MyPageEvent, MyPageState> {
  MyPageBloc() : super(const MyPageState()) {
    on<MyPagePageInitiated>(
      _onMyPagePageInitiated,
      transformer: log(),
    );
  }

  FutureOr<void> _onMyPagePageInitiated(
    MyPagePageInitiated event,
    Emitter<MyPageState> emit,
  ) async {
    // Xin hãy ghi nhớ đặt tên Event theo convention:
    // <Tên Widget><Verb ở dạng Quá khứ>. VD: LoginButtonPressed, EmailTextFieldChanged, HomePageRefreshed
  }
}
