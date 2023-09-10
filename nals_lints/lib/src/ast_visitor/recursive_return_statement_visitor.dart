import '../index.dart';

class RecursiveReturnStatementVisitor extends RecursiveAstVisitor<void> {
  RecursiveReturnStatementVisitor({
    required this.onVisitReturnStatement,
  });
  void Function(ReturnStatement node) onVisitReturnStatement;

  @override
  void visitReturnStatement(ReturnStatement node) {
    onVisitReturnStatement(node);

    node.visitChildren(this);
  }
}
