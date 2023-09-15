import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_auth_response_data.freezed.dart';
part 'api_auth_response_data.g.dart';

@freezed
class ApiAuthResponseData with _$ApiAuthResponseData {
  const factory ApiAuthResponseData({
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'username') String? username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'gender') String? gender,
    @JsonKey(name: 'age_range') String? ageRange,
  }) = _ApiAuthResponseData;

  factory ApiAuthResponseData.fromJson(Map<String, dynamic> json) =>
      _$ApiAuthResponseDataFromJson(json);
}
