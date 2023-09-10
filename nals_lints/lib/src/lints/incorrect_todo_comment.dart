import '../index.dart';

class IncorrectTodoComment extends DartLintRule {
  const IncorrectTodoComment() : super(code: _code);

  static const _code = LintCode(
    name: 'incorrect_todo_comment',
    problemMessage:
        'TODO comments must have username, description and issue number (or #0 if no issue).\n'
        'Example: // TODO(username): some description text #123.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    resolver.getLineContents((codeLine) {
      if (codeLine.isEndOfLineComment) {
        if (codeLine.content.contains(RegExp(r'//\s*TODO')) &&
            !RegExp(r'^\/\/\s*TODO\(.+\):.*#\d+.*$').hasMatch(codeLine.content.trim())) {
          reporter.reportErrorForOffset(code, codeLine.lineOffset, codeLine.lineLength);
        }
      }
    });
  }
}
