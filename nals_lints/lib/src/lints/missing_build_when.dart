import '../index.dart';

class MissingBuildWhen extends DartLintRule {
  const MissingBuildWhen() : super(code: _code);

  static const _code = LintCode(
    name: 'missing_build_when',
    problemMessage: '\'BlocBuilder\' objects must declare \'buildWhen\' parameter.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (node.staticType?.toString().trim().startsWith('BlocBuilder') == true &&
          node.argumentList.arguments
                  .whereType<NamedExpression>()
                  .any((element) => element.name.label.name == 'buildWhen') ==
              false) {
        reporter.reportErrorForNode(code, node);
      }
    });
  }

  @override
  List<Fix> getFixes() => [
        AddBuildWhen(),
      ];
}

class AddBuildWhen extends DartFix {
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
          node.staticType?.toString().trim().startsWith('BlocBuilder') != true) {
        return;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Add buildWhen',
        priority: 81,
      );

      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleInsertion(node.argumentList.leftParenthesis.end,
            'buildWhen: (previous, current) => previous.xxx != current.xxx,');
        builder.formatWithPageWidth(node.sourceRange);
      });
    });
  }
}
