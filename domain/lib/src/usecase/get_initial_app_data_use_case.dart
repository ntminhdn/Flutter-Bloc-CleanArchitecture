import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';

part 'get_initial_app_data_use_case.freezed.dart';

@Injectable()
class GetInitialAppDataUseCase
    extends BaseSyncUseCase<GetInitialAppDataInput, GetInitialAppDataOutput> {
  const GetInitialAppDataUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  GetInitialAppDataOutput buildUseCase(GetInitialAppDataInput input) {
    return GetInitialAppDataOutput(
      isDarkMode: _repository.isDarkMode,
      isLoggedIn: _repository.isLoggedIn,
      languageCode: _repository.languageCode,
    );
  }
}

@freezed
class GetInitialAppDataInput extends BaseInput with _$GetInitialAppDataInput {
  const factory GetInitialAppDataInput() = _GetInitialAppDataInput;
}

@freezed
class GetInitialAppDataOutput extends BaseOutput with _$GetInitialAppDataOutput {
  const GetInitialAppDataOutput._();

  const factory GetInitialAppDataOutput({
    @Default(false) bool isLoggedIn,
    @Default(false) bool isDarkMode,
    @Default(LanguageCode.ja) LanguageCode languageCode,
  }) = _GetInitialAppDataOutput;
}
