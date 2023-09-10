import '../index.dart';

extension MethodDeclarationExt on MethodDeclaration {
  List<MethodDeclaration> get pearMethodDeclarations {
    return parentClassDeclaration?.childEntities.whereType<MethodDeclaration>().toList() ??
        <MethodDeclaration>[];
  }

  bool get isOverrideMethod => toString().trim().contains('@override');
}
