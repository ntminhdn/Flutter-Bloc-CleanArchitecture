class CodeLine {
  final int lineNumber;
  final int lineOffset;
  final int lineLength;
  final String content;
  final bool isComment;

  CodeLine({
    required this.lineNumber,
    required this.lineOffset,
    required this.lineLength,
    required this.content,
    required this.isComment,
  });

  bool get isImportStatement => content.trim().startsWith('import');
  bool get isString {
    const regex = '^[\'"].+[\'"] *[,;]\$';

    return RegExp(regex).hasMatch(content.trim());
  }
}
