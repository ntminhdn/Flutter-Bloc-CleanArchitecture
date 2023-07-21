import '../index.dart';

extension FormalParameterExt on FormalParameter {
  DartType? get type => declaredElement?.type;

  bool get hasDefaultValue => declaredElement?.hasDefaultValue == true;

  String? get defaultValue => declaredElement?.defaultValueCode;

  bool get isNullableType => type?.isNullableType == true;
}
