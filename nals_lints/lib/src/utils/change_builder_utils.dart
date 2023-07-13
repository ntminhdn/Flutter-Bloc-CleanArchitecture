import '../index.dart';

extension DartFileEditBuilderExt on DartFileEditBuilder {
  void formatWithPageWidth(SourceRange range, {int pageWidth = 100}) {
    if (this is! DartFileEditBuilderImpl) {
      format(range);

      return;
    }

    final builder = this as DartFileEditBuilderImpl;

    var newContent = builder.resolvedUnit.content;
    var newRangeOffset = range.offset;
    var newRangeLength = range.length;
    for (var edit in builder.fileEdit.edits) {
      newContent = edit.apply(newContent);

      final lengthDelta = edit.replacement.length - edit.length;
      if (edit.offset < newRangeOffset) {
        newRangeOffset += lengthDelta;
      } else if (edit.offset < newRangeOffset + newRangeLength) {
        newRangeLength += lengthDelta;
      }
    }

    final formattedResult = DartFormatter(pageWidth: pageWidth).formatSource(
      SourceCode(
        newContent,
        isCompilationUnit: true,
        selectionStart: newRangeOffset,
        selectionLength: newRangeLength,
      ),
    );

    builder.replaceEdits(
      range,
      SourceEdit(
        range.offset,
        range.length,
        formattedResult.selectedText,
      ),
    );
  }
}
