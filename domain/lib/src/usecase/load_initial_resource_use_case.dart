import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

part 'load_initial_resource_use_case.freezed.dart';

@Injectable()
class LoadInitialResourceUseCase
    extends BaseSyncUseCase<LoadInitialResourceInput, LoadInitialResourceOutput> {
  const LoadInitialResourceUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  LoadInitialResourceOutput buildUseCase(LoadInitialResourceInput input) {
    final initialRoutes = [_repository.isLoggedIn ? AppRoute.main : AppRoute.login];

    return LoadInitialResourceOutput(initialRoutes: initialRoutes);
  }
}

@freezed
class LoadInitialResourceInput extends BaseInput with _$LoadInitialResourceInput {
  const factory LoadInitialResourceInput() = _LoadInitialResourceInput;
}

@freezed
class LoadInitialResourceOutput extends BaseOutput with _$LoadInitialResourceOutput {
  const LoadInitialResourceOutput._();

  const factory LoadInitialResourceOutput({
    @Default([AppRoute.main]) List<AppRoute> initialRoutes,
  }) = _LoadInitialResourceOutput;
}
