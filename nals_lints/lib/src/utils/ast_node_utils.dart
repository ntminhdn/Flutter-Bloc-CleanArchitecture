import '../index.dart';

extension AstNodeExt on AstNode {
  ClassDeclaration? get parentClassDeclaration => thisOrAncestorOfType<ClassDeclaration>();

  List<MethodInvocation> get childMethodInvocations {
    final methodInvocations = <MethodInvocation>[];
    visitChildren(RecursiveMethodInvocationVisitor(
      onVisitMethodInvocation: methodInvocations.add,
    ));

    return methodInvocations;
  }

  List<AwaitExpression> get childAwaitExpressions {
    final awaitExpressions = <AwaitExpression>[];
    visitChildren(RecursiveAwaitExpressionVisitor(
      onVisitAwaitExpression: awaitExpressions.add,
    ));

    return awaitExpressions;
  }

  List<ReturnStatement> get childReturnStatements {
    final returnStatements = <ReturnStatement>[];
    visitChildren(RecursiveReturnStatementVisitor(
      onVisitReturnStatement: returnStatements.add,
    ));

    return returnStatements;
  }

  SourceRange get sourceRange => SourceRange(offset, length);
}
