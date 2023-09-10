import '../index.dart';

class MissingListenWhen extends DartLintRule {
  const MissingListenWhen() : super(code: _code);

  static const _code = LintCode(
    name: 'missing_listen_when',
    problemMessage: '\'BlocListener\' objects must declare \'listenWhen\' parameter.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (node.staticType?.toString().trim().startsWith('BlocListener') == true &&
          node.argumentList.arguments
                  .whereType<NamedExpression>()
                  .any((element) => element.name.label.name == 'listenWhen') ==
              false) {
        reporter.reportErrorForNode(code, node);
      }
    });
  }

  @override
  List<Fix> getFixes() => [
        AddListenWhen(),
      ];
}

class AddListenWhen extends DartFix {
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
          node.staticType?.toString().trim().startsWith('BlocListener') != true) {
        return;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Add listenWhen',
        priority: 82,
      );

      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleInsertion(node.argumentList.leftParenthesis.end,
            'listenWhen: (previous, current) => previous.xxx != current.xxx,');
        builder.formatWithPageWidth(node.sourceRange);
      });
    });
  }
}
