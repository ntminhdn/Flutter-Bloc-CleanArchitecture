import '../index.dart';

extension DartTypeExt on DartType {
  bool get isNullableType => nullabilitySuffix == NullabilitySuffix.question;

  bool get isVoidType => this is VoidType;

  bool get isDynamicType => this is DynamicType;
}
