import 'src/index.dart';

PluginBase createPlugin() => _NalsLintsPlugin();

class _NalsLintsPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    return [
      const MissingRunBlocCatching(),
      const UnnecessaryAsyncFunction(),
      const AvoidHardCodedColors(),
      const LinesLongerThan100Chars(),
    ];
  }
}
