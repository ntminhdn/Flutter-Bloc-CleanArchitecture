import '../index.dart';

class PreferNamedParameters extends DartLintRule {
  const PreferNamedParameters() : super(code: _code);

  static const _code = LintCode(
    name: 'prefer_named_parameters',
    problemMessage:
        'If a function or a constuctor has more than one parameter, use named parameters',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    resolver.getResolvedUnitResult().then((value) =>
        value.unit.visitChildren(RecursiveConstructorAndFunctionAndMethodDeclarationVisitor(
          onVisitFunctionDeclaration: (FunctionDeclaration node) {
            final parameters =
                node.functionExpression.parameters?.parameters ?? <FormalParameter>[];
            if (parameters.length > 1 &&
                parameters.where((element) => element.isNamed).length != parameters.length) {
              reporter.reportErrorForNode(code, node.functionExpression.parameters!);
            }
          },
          onVisitMethodDeclaration: (MethodDeclaration node) {
            final parameters = node.parameters?.parameters ?? <FormalParameter>[];
            if (parameters.length > 1 &&
                !_isMethodDeclarationException(node) &&
                !node.isOverrideMethod &&
                parameters.where((element) => element.isNamed).length != parameters.length) {
              reporter.reportErrorForNode(code, node.parameters!);
            }
          },
          onVisitConstructorDeclaration: (ConstructorDeclaration node) {
            final parameters = node.parameters.parameters;
            if (parameters.length > 1 &&
                !_isConstuctorDeclarationException(node) &&
                parameters.where((element) => element.isNamed).length != parameters.length) {
              reporter.reportErrorForNode(code, node.parameters);
            }
          },
        )));
  }

  bool _isMethodDeclarationException(MethodDeclaration node) {
    return node.parentClassDeclaration?.name.toString().endsWith('Bloc') == true &&
        node.name.toString().startsWith('_on');
  }

  bool _isConstuctorDeclarationException(ConstructorDeclaration node) {
    return node.name.toString() == 'fromJson' ||
        node.parentClassDeclaration?.toString().trim().startsWith(
                RegExp(r'@injectable|@lazySingleton|@singleton', caseSensitive: false)) ==
            true;
  }

  @override
  List<Fix> getFixes() => [
        ConvertToNamedParameters(),
      ];
}

class ConvertToNamedParameters extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    resolver.getResolvedUnitResult().then((value) => value.unit.visitChildren(
            RecursiveConstructorAndFunctionAndMethodDeclarationVisitor(
                onVisitFunctionDeclaration: (FunctionDeclaration node) {
          if (node.functionExpression.parameters == null ||
              !node.functionExpression.parameters!.sourceRange
                  .intersects(analysisError.sourceRange)) {
            return;
          }

          _fix(parameterList: node.functionExpression.parameters!, reporter: reporter);
        }, onVisitMethodDeclaration: (MethodDeclaration node) {
          if (node.parameters == null ||
              !node.parameters!.sourceRange.intersects(analysisError.sourceRange)) {
            return;
          }

          _fix(parameterList: node.parameters!, reporter: reporter);
        }, onVisitConstructorDeclaration: (node) {
          if (!node.parameters.sourceRange.intersects(analysisError.sourceRange)) {
            return;
          }

          _fix(
            parameterList: node.parameters,
            reporter: reporter,
          );
        })));
  }

  void _fix({
    required FormalParameterList parameterList,
    required ChangeReporter reporter,
  }) {
    final changeBuilder = reporter.createChangeBuilder(
      message: 'Convert to named parameters',
      priority: 76,
    );

    final parameters = parameterList.parameters
        .map((e) =>
            e.isNullableType || e.hasDefaultValue || e.toString().trim().startsWith('required')
                ? e.toString()
                : 'required $e')
        .join(', ');

    changeBuilder.addDartFileEdit((builder) {
      builder.addSimpleReplacement(parameterList.sourceRange, '({$parameters,})');
      builder.formatWithPageWidth(parameterList.sourceRange);
    });
  }
}
