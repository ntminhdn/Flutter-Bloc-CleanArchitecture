import '../index.dart';

class AvoidNestedIfStatements extends DartLintRule {
  const AvoidNestedIfStatements() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_nested_if_statements',
    problemMessage:
        'Avoid nested if statements. Only use at most 2 nested if statements. Try to use \'early return\' instead.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addIfStatement((node) {
      final parentIfStatement = node.parent?.thisOrAncestorOfType<IfStatement>();
      if (parentIfStatement != null) {
        final parentOfParentIfStatement =
            parentIfStatement.parent?.thisOrAncestorOfType<IfStatement>();
        if (parentOfParentIfStatement != null) {
          reporter.reportErrorForNode(code, node);
        }
      }
    });
  }
}
