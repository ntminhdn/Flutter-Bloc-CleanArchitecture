import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';

part 'get_initial_home_data_use_case.freezed.dart';

@Injectable()
class GetInitialHomeDataUseCase
    extends BaseFutureUseCase<GetInitialHomeDataInput, GetInitialHomeDataOutput> {
  GetInitialHomeDataUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<GetInitialHomeDataOutput> buildUseCase(GetInitialHomeDataInput input) async {
    final isLoggedIn = _repository.isLoggedIn;
    final isFirstLaunchApp = _repository.isFirstLaunchApp;

    return GetInitialHomeDataOutput(
      isLoggedIn: isLoggedIn,
      isFirstLaunchApp: isFirstLaunchApp,
    );
  }
}

@freezed
class GetInitialHomeDataInput extends BaseInput with _$GetInitialHomeDataInput {
  const factory GetInitialHomeDataInput() = _GetInitialHomeDataInput;
}

@freezed
class GetInitialHomeDataOutput extends BaseOutput with _$GetInitialHomeDataOutput {
  const GetInitialHomeDataOutput._();

  const factory GetInitialHomeDataOutput({
    @Default(false) bool isLoggedIn,
    @Default(true) bool isFirstLaunchApp,
  }) = _GetInitialHomeDataOutput;
}
