import '../index.dart';

class LinesLongerThan100Chars extends DartLintRule {
  const LinesLongerThan100Chars() : super(code: _code);

  static const _code = LintCode(
    name: 'lines_longer_than_100_chars',
    problemMessage:
        'The line length exceeds the 100-character limit.\nTry breaking the line across multiple lines.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    resolver.getLineContents((codeLine) {
      if (codeLine.lineLength > 100 &&
          !codeLine.isComment &&
          !codeLine.isImportStatement &&
          !codeLine.isExportStatement &&
          !codeLine.isString) {
        reporter.reportErrorForOffset(_code, codeLine.lineOffset, codeLine.lineLength);
      }
    });
  }

  @override
  List<Fix> getFixes() => [
        FormatCode(),
      ];
}

class FormatCode extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    final changeBuilder = reporter.createChangeBuilder(
      message: 'Format this document',
      priority: 78,
    );
    changeBuilder.addDartFileEdit((builder) {
      builder.formatWithPageWidth(resolver.documentRange);
    });
  }
}
