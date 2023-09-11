import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_token_data.freezed.dart';
part 'api_token_data.g.dart';

@freezed
class ApiTokenData with _$ApiTokenData {
  const factory ApiTokenData({
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'refresh_token') String? refreshToken,
  }) = _ApiTokenData;

  factory ApiTokenData.fromJson(Map<String, dynamic> json) => _$ApiTokenDataFromJson(json);
}
