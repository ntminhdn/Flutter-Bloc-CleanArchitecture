import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_data.freezed.dart';
part 'refresh_token_data.g.dart';

@freezed
class RefreshTokenData with _$RefreshTokenData {
  const factory RefreshTokenData({
    @JsonKey(name: 'access_token') String? accessToken,
  }) = _RefreshTokenData;

  factory RefreshTokenData.fromJson(Map<String, dynamic> json) => _$RefreshTokenDataFromJson(json);
}
