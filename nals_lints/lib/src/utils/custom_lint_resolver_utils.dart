import '../index.dart';

extension CustomLintResolverExt on CustomLintResolver {
  void getLineContents(void Function(CodeLine codeLine) onCodeLine) {
    var previousLineContent = '';
    var isMultiLineComment = false;
    for (final startOffset in lineInfo.lineStarts) {
      final lineCount = lineInfo.lineStarts.length;
      final lineNumber = lineInfo.getLocation(startOffset).lineNumber;
      if (lineNumber <= lineCount - 1) {
        final startOffsetOfNextLine = lineInfo.getOffsetOfLineAfter(startOffset);
        final lineLength = startOffsetOfNextLine - startOffset - 1;
        final content = source.contents.data.substring(
          startOffset,
          startOffsetOfNextLine,
        );

        final isDocumentationComment = content.trim().startsWith('///');

        final isSingleLineComment = content.trim().startsWith('//') && !isDocumentationComment;

        if (content.trim().startsWith('/*')) {
          isMultiLineComment = true;
        }

        if (previousLineContent.trim().endsWith('*/') && isMultiLineComment) {
          isMultiLineComment = false;
        }

        previousLineContent = content;

        onCodeLine(
          CodeLine(
            lineNumber: lineNumber,
            lineOffset: startOffset,
            lineLength: lineLength,
            content: content,
            isEndOfLineComment: isSingleLineComment,
            isBlockComment: isMultiLineComment,
            isDocumentationComment: isDocumentationComment,
          ),
        );
      }
    }
  }

  SourceRange get documentRange => SourceRange(
        0,
        lineInfo.getOffsetOfLineAfter(lineInfo.lineStarts[lineInfo.lineStarts.length - 2]) - 1,
      );
}
