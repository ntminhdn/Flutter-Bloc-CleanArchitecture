import 'package:async/async.dart';

abstract class Config {
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer<void>();

  Future<void> config();

  Future<void> init() => _asyncMemoizer.runOnce(config);
}
