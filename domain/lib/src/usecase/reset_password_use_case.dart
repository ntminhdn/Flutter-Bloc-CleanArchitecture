import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';

part 'reset_password_use_case.freezed.dart';

@Injectable()
class ResetPasswordUseCase extends BaseFutureUseCase<ResetPasswordInput, ResetPasswordOutput> {
  const ResetPasswordUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<ResetPasswordOutput> buildUseCase(ResetPasswordInput input) async {
    if (!ValidationUtils.isValidPassword(input.password)) {
      throw const ValidationException(ValidationExceptionKind.invalidPassword);
    }
    if (!ValidationUtils.isValidPassword(input.confirmPassword)) {
      throw const ValidationException(ValidationExceptionKind.invalidPassword);
    }
    if (input.password != input.confirmPassword) {
      throw const ValidationException(ValidationExceptionKind.passwordsAreNotMatch);
    }
    if (!ValidationUtils.isValidEmail(input.email)) {
      throw const ValidationException(ValidationExceptionKind.invalidEmail);
    }

    await _repository.resetPassword(
      token: input.token,
      email: input.email,
      password: input.password,
      confirmPassword: input.confirmPassword,
    );

    return const ResetPasswordOutput();
  }
}

@freezed
class ResetPasswordInput extends BaseInput with _$ResetPasswordInput {
  const factory ResetPasswordInput({
    required String token,
    required String email,
    required String password,
    required String confirmPassword,
  }) = _ResetPasswordInput;
}

@freezed
class ResetPasswordOutput extends BaseOutput with _$ResetPasswordOutput {
  const ResetPasswordOutput._();

  const factory ResetPasswordOutput() = _ResetPasswordOutput;
}
