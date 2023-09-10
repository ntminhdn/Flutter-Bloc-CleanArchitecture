import '../index.dart';

class AvoidHardCodedColors extends DartLintRule {
  const AvoidHardCodedColors() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_hard_coded_colors',
    problemMessage:
        'Avoid hard-coding colors, except for Colors.transparent, such as Color(0xFFFFFF) and Colors.white.\nPlease use \'AppColors\' instead',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    resolver
        .getResolvedUnitResult()
        .then((value) => value.unit.visitChildren(VariableAndArgumentVisitor(
              onVisitInstanceCreationExpression: (InstanceCreationExpression node) {
                node.argumentList.arguments.forEach((element) {
                  if (element is NamedExpression) {
                    if (_isHardCoded(element.expression.toString())) {
                      reporter.reportErrorForNode(code, element.expression);
                    }
                  } else if (_isHardCoded(element.toString())) {
                    reporter.reportErrorForNode(code, element);
                  }
                });
              },
              onVisitVariableDeclaration: (VariableDeclaration node) {
                if (node.initializer != null && _isHardCoded(node.initializer.toString())) {
                  reporter.reportErrorForNode(code, node.initializer!);
                }
              },
              onVisitAssignmentExpression: (AssignmentExpression node) {
                if (_isHardCoded(node.rightHandSide.toString())) {
                  reporter.reportErrorForNode(code, node.rightHandSide);
                }
              },
              onVisitConstructorFieldInitializer: (ConstructorFieldInitializer node) {
                if (_isHardCoded(node.expression.toString())) {
                  reporter.reportErrorForNode(code, node.expression);
                }
              },
              onVisitSuperConstructorInvocation: (SuperConstructorInvocation node) {
                node.argumentList.arguments.forEach((element) {
                  if (element is NamedExpression) {
                    if (_isHardCoded(element.expression.toString())) {
                      reporter.reportErrorForNode(code, element.expression);
                    }
                  } else if (_isHardCoded(element.toString())) {
                    reporter.reportErrorForNode(code, element);
                  }
                });
              },
              onVisitConstructorDeclaration: (ConstructorDeclaration node) {
                node.parameters.parameterElements.forEach((element) {
                  if (element?.defaultValueCode != null &&
                      _isHardCoded(element!.defaultValueCode!)) {
                    if (element is DefaultFieldFormalParameterElementImpl) {
                      reporter.reportErrorForNode(code, element.constantInitializer!);
                    } else if (element is DefaultParameterElementImpl) {
                      reporter.reportErrorForNode(code, element.constantInitializer!);
                    } else {
                      reporter.reportErrorForNode(code, node);
                    }
                  }
                });
              },
              onVisitArgumentList: (node) {
                node.arguments.forEach((element) {
                  if (element is NamedExpression) {
                    if (_isHardCoded(element.expression.toString())) {
                      reporter.reportErrorForNode(code, element.expression);
                    }
                  } else if (_isHardCoded(element.toString())) {
                    reporter.reportErrorForNode(code, element);
                  }
                });
              },
            )));
  }

  bool _isHardCoded(String color) {
    if (color == 'Colors.transparent') {
      return false;
    }

    if (color.replaceAll(' ', '').startsWith('Color(') ||
        color.replaceAll(' ', '').startsWith('Colors.') ||
        color.replaceAll(' ', '').startsWith('Color.')) {
      return true;
    }

    return false;
  }
}
