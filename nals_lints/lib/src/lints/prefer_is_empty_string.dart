import '../index.dart';

class PreferIsEmptyString extends DartLintRule {
  const PreferIsEmptyString() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_is_empty_string',
    problemMessage:
        'Use \'isEmpty\' instead of \'==\' to test whether the string is empty.\nTry rewriting the expression to use \'isEmpty\'.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addBinaryExpression((node) {
      if (node.operator.type == TokenType.EQ_EQ &&
          (node.leftOperand.toString() == '\'\'' || node.rightOperand.toString() == '\'\'')) {
        reporter.reportErrorForNode(code, node);
      }
    });
  }

  @override
  List<Fix> getFixes() => [
        ReplaceWithIsEmpty(),
      ];
}

class ReplaceWithIsEmpty extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    context.registry.addBinaryExpression((node) {
      if (!node.sourceRange.intersects(analysisError.sourceRange) ||
          node.operator.type != TokenType.EQ_EQ ||
          (node.leftOperand.toString() != '\'\'' && node.rightOperand.toString() != '\'\'')) {
        return;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Replace with \'isEmpty\'',
        priority: 71,
      );

      final variable = node.leftOperand.toString() == '\'\'' ? node.rightOperand : node.leftOperand;

      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(
            node.sourceRange,
            variable.staticType?.isNullableType == true
                ? '${variable.toString()}?.isEmpty == true'
                : '${variable.toString()}.isEmpty');
      });
    });
  }
}
