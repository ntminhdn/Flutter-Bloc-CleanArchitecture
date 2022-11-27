import '../../shared.dart';

class ParseUtils {
  const ParseUtils._();

  static BigDecimal parseStringToBigDecimal(String value) {
    try {
      return BigDecimal.parse(value);
    } on FormatException catch (e) {
      throw ParseException(ParseExceptionKind.invalidSourceFormat, e);
    }
  }

  static int parseStringToInt(String value) {
    try {
      return int.parse(value);
    } on FormatException catch (e) {
      throw ParseException(ParseExceptionKind.invalidSourceFormat, e);
    }
  }

  static double parseStringToDouble(String value) {
    try {
      return double.parse(value);
    } on FormatException catch (e) {
      throw ParseException(ParseExceptionKind.invalidSourceFormat, e);
    }
  }
}
