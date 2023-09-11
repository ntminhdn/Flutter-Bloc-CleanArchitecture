class CodeLine {
  final int lineNumber;
  final int lineOffset;
  final int lineLength;
  final String content;
  final bool isEndOfLineComment;
  final bool isBlockComment;
  final bool isDocumentationComment;

  CodeLine({
    required this.lineNumber,
    required this.lineOffset,
    required this.lineLength,
    required this.content,
    required this.isEndOfLineComment,
    required this.isBlockComment,
    required this.isDocumentationComment,
  });

  bool get isComment => isEndOfLineComment || isBlockComment || isDocumentationComment;

  bool get isImportStatement => content.trim().startsWith('import ');

  bool get isExportStatement => content.trim().startsWith('export ');

  bool get isString {
    const regex = '^(return\\s*)?r?[\'"].+[\'"] *\\)?[,;]\$';

    return RegExp(regex).hasMatch(content.trim());
  }

  @override
  String toString() {
    return 'CodeLine{lineNumber: $lineNumber, lineOffset: $lineOffset, lineLength: $lineLength, content: $content, isEndOfLineComment: $isEndOfLineComment, isBlockComment: $isBlockComment, isDocumentationComment: $isDocumentationComment, isImportStatement: $isImportStatement, isString: $isString}';
  }
}
