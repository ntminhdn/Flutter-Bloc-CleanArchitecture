import '../index.dart';

class RecursiveMethodInvocationVisitor extends RecursiveAstVisitor<void> {
  RecursiveMethodInvocationVisitor({
    required this.onVisitMethodInvocation,
  });
  void Function(MethodInvocation node) onVisitMethodInvocation;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    onVisitMethodInvocation(node);

    // Recursively visit nested MethodInvocation nodes
    node.visitChildren(this);
  }
}
