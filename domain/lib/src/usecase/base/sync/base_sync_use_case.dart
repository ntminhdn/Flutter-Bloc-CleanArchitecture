import 'package:shared/shared.dart';

import '../../../../domain.dart';

abstract class BaseSyncUseCase<Input extends BaseInput, Output extends BaseOutput>
    extends BaseUseCase<Input, Output> {
  const BaseSyncUseCase();

  Output execute(Input input) {
    try {
      if (LogConfig.enableLogUseCaseInput) {
        logD('SyncUseCase Input: $input');
      }
      final output = buildUseCase(input);
      if (LogConfig.enableLogUseCaseOutput) {
        logD('SyncUseCase Output: $output');
      }

      return output;
    } catch (e) {
      if (LogConfig.enableLogUseCaseError) {
        logE('SyncUseCase Error: $e');
      }

      throw e is AppException ? e : AppUncaughtException(e);
    }
  }
}
