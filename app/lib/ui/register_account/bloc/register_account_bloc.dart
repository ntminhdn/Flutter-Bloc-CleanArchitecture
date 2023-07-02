import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'register_account.dart';
  
@Injectable()
class RegisterAccountBloc extends BaseBloc<RegisterAccountEvent, RegisterAccountState> {
  RegisterAccountBloc() : super(const RegisterAccountState()) {
    on<RegisterAccountPageInitiated>(
      _onRegisterAccountPageInitiated,
      transformer: log(),
    );
  }


  FutureOr<void> _onRegisterAccountPageInitiated(
    RegisterAccountPageInitiated event,
    Emitter<RegisterAccountState> emit,
  ) async {
    
  }
}
