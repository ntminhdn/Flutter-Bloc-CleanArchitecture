import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

part 'save_language_code_use_case.freezed.dart';

@Injectable()
class SaveLanguageCodeUseCase
    extends BaseFutureUseCase<SaveLanguageCodeInput, SaveLanguageCodeOutput> {
  const SaveLanguageCodeUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<SaveLanguageCodeOutput> buildUseCase(SaveLanguageCodeInput input) async {
    await _repository.saveLanguageCode(input.languageCode);

    return const SaveLanguageCodeOutput();
  }
}

@freezed
class SaveLanguageCodeInput extends BaseInput with _$SaveLanguageCodeInput {
  const factory SaveLanguageCodeInput({
    required LanguageCode languageCode,
  }) = _SaveLanguageCodeUseCase;
}

@freezed
class SaveLanguageCodeOutput extends BaseOutput with _$SaveLanguageCodeOutput {
  const SaveLanguageCodeOutput._();

  const factory SaveLanguageCodeOutput() = _SaveLanguageCodeOutput;
}
