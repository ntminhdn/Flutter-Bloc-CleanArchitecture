import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';

import '../../../domain.dart';

part 'fake_login_use_case.freezed.dart';

@Injectable()
class FakeLoginUseCase extends BaseFutureUseCase<FakeLoginInput, FakeLoginOutput> {
  const FakeLoginUseCase(this._navigator);

  final AppNavigator _navigator;

  @protected
  @override
  Future<FakeLoginOutput> buildUseCase(FakeLoginInput input) async {
    await _navigator.showDialog(
      const AppPopupInfo.requiredLoginDialog(),
      useRootNavigator: false,
    );

    return FakeLoginOutput(status: S.current.ok);
  }
}

@freezed
class FakeLoginInput extends BaseInput with _$FakeLoginInput {
  const factory FakeLoginInput() = _FakeLoginInput;
}

@freezed
class FakeLoginOutput extends BaseOutput with _$FakeLoginOutput {
  const FakeLoginOutput._();

  const factory FakeLoginOutput({
    @Default('') String status,
  }) = _FakeLoginOutput;
}
