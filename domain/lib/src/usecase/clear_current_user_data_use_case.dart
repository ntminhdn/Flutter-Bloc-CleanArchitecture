import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

part 'clear_current_user_data_use_case.freezed.dart';

@Injectable()
class ClearCurrentUserDataUseCase
    extends BaseFutureUseCase<ClearCurrentUserDataInput, ClearCurrentUserDataOutput> {
  const ClearCurrentUserDataUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<ClearCurrentUserDataOutput> buildUseCase(
    ClearCurrentUserDataInput input,
  ) async {
    await _repository.clearCurrentUserData();

    return const ClearCurrentUserDataOutput();
  }
}

@freezed
class ClearCurrentUserDataInput extends BaseInput with _$ClearCurrentUserDataInput {
  const factory ClearCurrentUserDataInput() = _ClearCurrentUserDataInput;
}

@freezed
class ClearCurrentUserDataOutput extends BaseOutput with _$ClearCurrentUserDataOutput {
  const ClearCurrentUserDataOutput._();

  const factory ClearCurrentUserDataOutput() = _ClearCurrentUserDataOutput;
}
