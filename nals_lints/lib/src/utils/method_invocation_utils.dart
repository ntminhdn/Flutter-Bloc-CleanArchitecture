import '../index.dart';

extension MethodInvocationExt on MethodInvocation {
  List<InterfaceType> get allTargetSupertypes {
    return (realTarget?.staticType?.element as ClassElement?)?.allSupertypes ?? [];
  }
}
