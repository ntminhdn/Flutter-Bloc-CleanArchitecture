import 'package:freezed_annotation/freezed_annotation.dart';

part 'token.freezed.dart';

@freezed
class Token with _$Token {
  const factory Token({@Default('') String accessToken, @Default('') String refreshToken}) = _Token;
}
