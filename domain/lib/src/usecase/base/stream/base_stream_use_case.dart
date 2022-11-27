import 'package:shared/shared.dart';

import '../../../../domain.dart';

abstract class BaseStreamUseCase<Input extends BaseInput, Output>
    extends BaseUseCase<Input, Stream<Output>> {
  const BaseStreamUseCase();

  Stream<Output> execute(Input input) {
    return buildUseCase(input).log(runtimeType.toString());
  }
}
