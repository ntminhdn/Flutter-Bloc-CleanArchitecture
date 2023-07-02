import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app.dart';
  
part 'register_account_event.freezed.dart';

abstract class RegisterAccountEvent extends BaseBlocEvent {
  const RegisterAccountEvent();
}

@freezed
class RegisterAccountPageInitiated extends RegisterAccountEvent with _$RegisterAccountPageInitiated {
  const factory RegisterAccountPageInitiated() = _RegisterAccountPageInitiated;
}
