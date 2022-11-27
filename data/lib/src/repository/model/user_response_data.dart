import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_data.dart';

part 'user_response_data.freezed.dart';
part 'user_response_data.g.dart';

@freezed
class UserResponseData with _$UserResponseData {
  const factory UserResponseData({
    @JsonKey(name: 'user') UserData? userData,
  }) = _UserResponseData;

  factory UserResponseData.fromJson(Map<String, dynamic> json) => _$UserResponseDataFromJson(json);
}
