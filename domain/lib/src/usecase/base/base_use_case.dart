import 'package:meta/meta.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';

abstract class BaseUseCase<Input extends BaseInput, Output> with LogMixin {
  const BaseUseCase();

  @protected
  Output buildUseCase(Input input);
}
