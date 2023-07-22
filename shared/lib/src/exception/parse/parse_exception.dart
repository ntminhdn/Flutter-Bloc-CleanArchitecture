import '../../../shared.dart';

class ParseException extends AppException {
  const ParseException({
    required this.kind,
    this.rootException,
  }) : super(AppExceptionType.parse);

  final ParseExceptionKind kind;
  final Object? rootException;

  @override
  String toString() {
    return 'ParseException: {kind: $kind, rootException: $rootException}';
  }
}

enum ParseExceptionKind {
  invalidSourceFormat,
}
