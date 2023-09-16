import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';

part 'fake_login_use_case.freezed.dart';

@Injectable()
class FakeLoginUseCase extends BaseFutureUseCase<FakeLoginInput, FakeLoginOutput> {
  const FakeLoginUseCase(this._navigator, this._repository);

  final AppNavigator _navigator;
  final Repository _repository;

  @protected
  @override
  Future<FakeLoginOutput> buildUseCase(FakeLoginInput input) async {
    await _navigator.showDialog(
      AppPopupInfo.confirmDialog(
          message: S.current.login,
          onPressed: Func0(() async {
            await _repository.saveAccessToken('fakeToken');
            await _navigator.replace(const AppRouteInfo.main());
          })),
      useRootNavigator: false,
    );

    return const FakeLoginOutput();
  }
}

@freezed
class FakeLoginInput extends BaseInput with _$FakeLoginInput {
  const factory FakeLoginInput() = _FakeLoginInput;
}

@freezed
class FakeLoginOutput extends BaseOutput with _$FakeLoginOutput {
  const FakeLoginOutput._();

  const factory FakeLoginOutput() = _FakeLoginOutput;
}
