import '../index.dart';

class MissingRunBlocCatching extends DartLintRule {
  const MissingRunBlocCatching() : super(code: _code);

  static const _code = LintCode(
    name: 'missing_run_bloc_catching',
    problemMessage: 'Use cases must be executed inside runBlocCatching or runCatching function',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      if (node.methodName.name == 'execute' &&
          node.allTargetSupertypes
              .where((element) =>
                  element.toString().startsWith('BaseFutureUseCase') ||
                  element.toString().startsWith('BaseLoadMoreUseCase') ||
                  element.toString().startsWith('BaseSyncUseCase'))
              .isNotEmpty &&
          node.thisOrAncestorMatching((astNode) {
                if (astNode is MethodInvocation) {
                  if (astNode.methodName.name == 'runBlocCatching' ||
                      astNode.methodName.name == 'runCatching') {
                    return true;
                  }
                }

                if (astNode is MethodDeclaration) {
                  final methodInvocations = astNode.pearMethodDeclarations
                      .map((e) => e.childMethodInvocations)
                      .firstWhereOrNull((element) {
                    final runBlocCatchingMethodInvocation = element.firstWhereOrNull(
                        (methodInvocation) =>
                            methodInvocation.methodName.name == 'runBlocCatching' ||
                            methodInvocation.methodName.name == 'runCatching');

                    if (runBlocCatchingMethodInvocation == null) {
                      return false;
                    }

                    return runBlocCatchingMethodInvocation.childMethodInvocations.firstWhereOrNull(
                            (element) => element.methodName.name == astNode.name.toString()) !=
                        null;
                  });

                  if (methodInvocations != null) {
                    return true;
                  }
                }

                return false;
              }) ==
              null) {
        reporter.reportErrorForNode(code, node);
      }
    });
  }

  @override
  List<Fix> getFixes() => [
        WrapWithRunBlocCatching(),
      ];
}

class WrapWithRunBlocCatching extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    context.registry.addMethodInvocation((node) {
      // The method is not impacte by this analysis error
      if (!node.sourceRange.intersects(analysisError.sourceRange)) {
        return;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Wrap with runBlocCatching',
        priority: 80,
      );

      changeBuilder.addDartFileEdit((builder) {
        final firstArgument = node.argumentList.arguments.firstOrNull;
        if (firstArgument == null) {
          return;
        }

        const prefix = 'runBlocCatching(action: () async {';
        const postfix = '},);';
        builder.addSimpleInsertion(
          node.offset,
          prefix,
        );
        builder.addSimpleInsertion(node.end + 1, postfix);
        builder.formatWithPageWidth(
            SourceRange(node.offset - prefix.length, node.length + prefix.length + postfix.length));
      });
    });
  }
}
