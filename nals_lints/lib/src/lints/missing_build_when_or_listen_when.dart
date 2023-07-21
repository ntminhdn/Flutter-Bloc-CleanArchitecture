import '../index.dart';

class MissingBuildWhenOrListenWhen extends DartLintRule {
  const MissingBuildWhenOrListenWhen() : super(code: _code);

  static const _code = LintCode(
    name: 'missing_build_when_or_listen_when',
    problemMessage:
        '\'BlocConsumer\' objects must declare both \'buildWhen\' and \'listenWhen\' parameters.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (node.staticType?.toString().trim().startsWith('BlocConsumer') == true &&
          (node.argumentList.arguments
                      .whereType<NamedExpression>()
                      .any((element) => element.name.label.name == 'buildWhen') ==
                  false ||
              node.argumentList.arguments
                      .whereType<NamedExpression>()
                      .any((element) => element.name.label.name == 'listenWhen') ==
                  false)) {
        reporter.reportErrorForNode(code, node);
      }
    });
  }

  @override
  List<Fix> getFixes() => [
        AddBuildWhenAndListenWhen(),
      ];
}

class AddBuildWhenAndListenWhen extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (!node.sourceRange.intersects(analysisError.sourceRange) ||
          node.staticType?.toString().trim().startsWith('BlocConsumer') != true) {
        return;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Add buildWhen and listenWhen',
        priority: 83,
      );

      changeBuilder.addDartFileEdit((builder) {
        final isMissingBuildWhen = node.argumentList.arguments
                .whereType<NamedExpression>()
                .any((element) => element.name.label.name == 'buildWhen') ==
            false;
        final isMissingListenWhen = node.argumentList.arguments
                .whereType<NamedExpression>()
                .any((element) => element.name.label.name == 'listenWhen') ==
            false;
        builder.addSimpleInsertion(
            node.argumentList.leftParenthesis.end,
            isMissingBuildWhen && isMissingListenWhen
                ? 'buildWhen: (previous, current) => previous.xxx != current.xxx, listenWhen: (previous, current) => previous.xxx != current.xxx,'
                : isMissingBuildWhen
                    ? 'buildWhen: (previous, current) => previous.xxx != current.xxx,'
                    : 'listenWhen: (previous, current) => previous.xxx != current.xxx,');
        builder.formatWithPageWidth(node.sourceRange);
      });
    });
  }
}
