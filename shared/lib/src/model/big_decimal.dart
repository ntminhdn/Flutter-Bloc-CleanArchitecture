import 'package:decimal/decimal.dart';

class BigDecimal implements Comparable<BigDecimal> {
  const BigDecimal._([this._decimal]);
  factory BigDecimal.parse(String value) => BigDecimal._(Decimal.parse(value));
  factory BigDecimal.fromBigInt(BigInt value) => BigDecimal._(Decimal.fromBigInt(value));
  factory BigDecimal.fromInt(int value) => BigDecimal._(Decimal.fromInt(value));
  factory BigDecimal.fromJson(String value) => BigDecimal._(Decimal.fromJson(value));

  static const zero = BigDecimal._();

  final Decimal? _decimal;

  Decimal get decimal => _decimal ?? Decimal.zero;

  int get signum => decimal.signum;

  int get precision => decimal.precision;

  int get scale => decimal.scale;

  bool get isInteger => decimal.isInteger;

  @override
  int get hashCode => decimal.hashCode;

  static BigDecimal? tryParse(String? source) {
    if (source == null) {
      return null;
    }

    final decimal = Decimal.tryParse(source);

    return decimal != null ? BigDecimal._(decimal) : null;
  }

  @override
  bool operator ==(Object other) => other is BigDecimal && decimal == other.decimal;

  @override
  String toString() => decimal.toString();

  @override
  int compareTo(BigDecimal other) => decimal.compareTo(other.decimal);

  BigDecimal operator +(BigDecimal other) => BigDecimal._(decimal + other.decimal);

  BigDecimal operator -(BigDecimal other) => BigDecimal._(decimal - other.decimal);

  BigDecimal operator *(BigDecimal other) => BigDecimal._(decimal * other.decimal);

  BigDecimal operator %(BigDecimal other) => BigDecimal._(decimal % other.decimal);

  BigDecimal operator -() => BigDecimal._(-decimal);

  BigDecimal remainder(BigDecimal other) => BigDecimal._(decimal.remainder(other.decimal));

  bool operator <(BigDecimal other) => decimal < other.decimal;

  bool operator <=(BigDecimal other) => decimal <= other.decimal;

  bool operator >(BigDecimal other) => decimal > other.decimal;

  bool operator >=(BigDecimal other) => decimal >= other.decimal;

  BigDecimal abs() => BigDecimal._(decimal.abs());

  BigDecimal floor() => BigDecimal._(decimal.floor());

  BigDecimal ceil() => BigDecimal._(decimal.ceil());

  BigDecimal round() => BigDecimal._(decimal.round());

  BigDecimal truncate() => BigDecimal._(decimal.truncate());

  BigDecimal clamp(BigDecimal lowerLimit, BigDecimal upperLimit) =>
      BigDecimal._(decimal.clamp(lowerLimit.decimal, upperLimit.decimal));

  BigInt toBigInt() => decimal.toBigInt();

  double toDouble() => decimal.toDouble();

  String toStringAsFixed(int fractionDigits) => decimal.toStringAsFixed(fractionDigits);

  String toStringAsExponential(int fractionDigits) => decimal.toStringAsExponential(fractionDigits);

  String toStringAsPrecision(int precision) => decimal.toStringAsPrecision(precision);

  BigDecimal pow(int exponent) => BigDecimal._(decimal.pow(exponent));
  BigDecimal plus(BigDecimal other) => this + other;
  BigDecimal minus(BigDecimal other) => this - other;
  BigDecimal times(BigDecimal other) => this * other;
}
