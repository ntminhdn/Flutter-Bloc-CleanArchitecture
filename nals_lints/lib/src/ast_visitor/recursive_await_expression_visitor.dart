import '../index.dart';

class RecursiveAwaitExpressionVisitor extends RecursiveAstVisitor<void> {
  RecursiveAwaitExpressionVisitor({
    required this.onVisitAwaitExpression,
  });
  void Function(AwaitExpression node) onVisitAwaitExpression;

  @override
  void visitAwaitExpression(AwaitExpression node) {
    onVisitAwaitExpression(node);

    node.visitChildren(this);
  }
}
