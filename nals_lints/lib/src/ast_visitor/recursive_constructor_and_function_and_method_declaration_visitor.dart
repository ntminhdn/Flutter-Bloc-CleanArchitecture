import '../index.dart';

class RecursiveConstructorAndFunctionAndMethodDeclarationVisitor extends RecursiveAstVisitor<void> {
  RecursiveConstructorAndFunctionAndMethodDeclarationVisitor({
    required this.onVisitFunctionDeclaration,
    required this.onVisitMethodDeclaration,
    required this.onVisitConstructorDeclaration,
  });

  void Function(FunctionDeclaration node) onVisitFunctionDeclaration;
  void Function(MethodDeclaration node) onVisitMethodDeclaration;
  void Function(ConstructorDeclaration node) onVisitConstructorDeclaration;

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    onVisitFunctionDeclaration(node);

    node.visitChildren(this);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    onVisitMethodDeclaration(node);

    node.visitChildren(this);
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    onVisitConstructorDeclaration(node);

    node.visitChildren(this);
  }
}
