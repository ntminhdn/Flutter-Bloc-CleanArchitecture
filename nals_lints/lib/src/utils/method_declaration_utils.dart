import '../index.dart';

extension MethodDeclarationExt on MethodDeclaration {
  List<MethodDeclaration> get pearMethodDeclarations {
    return parentClassDeclaration?.childEntities.whereType<MethodDeclaration>().toList() ??
        <MethodDeclaration>[];
  }

  DartType? get returnTypeOfBlock => body.childReturnStatements.lastOrNull?.expression?.staticType;

  bool get isOverrideMethod => toString().trim().startsWith('@override');
}
