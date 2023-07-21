import '../index.dart';

class PreferIsNotEmptyString extends DartLintRule {
  const PreferIsNotEmptyString() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_is_not_empty_string',
    problemMessage:
        'Use \'isNotEmpty\' instead of \'!=\' to test whether the string is empty.\nTry rewriting the expression to use \'isNotEmpty\'.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addBinaryExpression((node) {
      if (node.operator.type == TokenType.BANG_EQ &&
          (node.leftOperand.toString() == '\'\'' || node.rightOperand.toString() == '\'\'')) {
        reporter.reportErrorForNode(code, node);
      }
    });
  }

  @override
  List<Fix> getFixes() => [
        ReplaceWithIsNotEmpty(),
      ];
}

class ReplaceWithIsNotEmpty extends DartFix {
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
          node.operator.type != TokenType.BANG_EQ ||
          (node.leftOperand.toString() != '\'\'' && node.rightOperand.toString() != '\'\'')) {
        return;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Replace with \'isNotEmpty\'',
        priority: 70,
      );

      final variable = node.leftOperand.toString() == '\'\'' ? node.rightOperand : node.leftOperand;

      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(
            node.sourceRange,
            variable.staticType?.isNullableType == true
                ? '${variable.toString()}?.isNotEmpty == true'
                : '${variable.toString()}.isNotEmpty');
      });
    });
  }
}
