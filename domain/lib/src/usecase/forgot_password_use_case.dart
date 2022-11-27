import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';

part 'forgot_password_use_case.freezed.dart';

@Injectable()
class ForgotPasswordUseCase extends BaseFutureUseCase<ForgotPasswordInput, ForgotPasswordOutput> {
  const ForgotPasswordUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<ForgotPasswordOutput> buildUseCase(ForgotPasswordInput input) async {
    if (!ValidationUtils.isEmptyEmail(input.email)) {
      throw const ValidationException(ValidationExceptionKind.emptyEmail);
    }
    if (!ValidationUtils.isValidEmail(input.email)) {
      throw const ValidationException(ValidationExceptionKind.invalidEmail);
    }
    await _repository.forgotPassword(input.email);

    return const ForgotPasswordOutput();
  }
}

@freezed
class ForgotPasswordInput extends BaseInput with _$ForgotPasswordInput {
  const factory ForgotPasswordInput({
    required String email,
  }) = _ForgotPasswordInput;
}

@freezed
class ForgotPasswordOutput extends BaseOutput with _$ForgotPasswordOutput {
  const ForgotPasswordOutput._();

  const factory ForgotPasswordOutput() = _ForgotPasswordOutput;
}
