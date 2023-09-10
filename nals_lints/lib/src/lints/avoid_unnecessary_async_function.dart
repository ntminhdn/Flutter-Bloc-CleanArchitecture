import '../index.dart';

class AvoidUnnecessaryAsyncFunction extends DartLintRule {
  const AvoidUnnecessaryAsyncFunction() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_unnecessary_async_function',
    problemMessage: 'This async function is unnecessary. Please remove \'async\' keyword',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodDeclaration((node) {
      if (node.body.isAsynchronous &&
          !node.isOverrideMethod &&
          node.body is BlockFunctionBody &&
          node.body.childAwaitExpressions.isEmpty &&
          !node.childReturnStatements.any((element) =>
              element.expression?.staticType.toString().startsWith('Future') == true)) {
        if (node.body.keyword != null) {
          reporter.reportErrorForToken(code, node.body.keyword!);
        } else {
          reporter.reportErrorForNode(code, node);
        }
      }
    });
  }

  @override
  List<Fix> getFixes() => [
        RemoveUnnecessaryAsyncKeyWord(),
      ];
}

class RemoveUnnecessaryAsyncKeyWord extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    context.registry.addMethodDeclaration((node) {
      // The method is not impacte by this analysis error
      if (!node.sourceRange.intersects(analysisError.sourceRange)) {
        return;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Remove unnecessary async keyword',
        priority: 79,
      );

      changeBuilder.addDartFileEdit((builder) {
        builder.addDeletion(analysisError.sourceRange);
        if (node.returnType != null && node.returnType.toString().startsWith('Future')) {
          builder.addSimpleReplacement(
              node.returnType!.sourceRange,
              node.returnType.toString().replaceFirstMapped(RegExp(r'(Future<|FutureOr<)(.+)>'),
                  (match) {
                return match.group(2) ?? '';
              }));
        }
        builder.formatWithPageWidth(node.sourceRange);
      });
    });
  }
}
