import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

part 'logout_use_case.freezed.dart';

@Injectable()
class LogoutUseCase extends BaseFutureUseCase<LogoutInput, LogoutOutput> {
  const LogoutUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<LogoutOutput> buildUseCase(LogoutInput input) async {
    if (_repository.isLoggedIn) {
      await _repository.logout();
    }

    return const LogoutOutput();
  }
}

@freezed
class LogoutInput extends BaseInput with _$LogoutInput {
  const factory LogoutInput() = _LogoutUseCase;
}

@freezed
class LogoutOutput extends BaseOutput with _$LogoutOutput {
  const LogoutOutput._();

  const factory LogoutOutput() = _LogoutOutput;
}
