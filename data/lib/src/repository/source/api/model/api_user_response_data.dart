import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data.dart';

part 'api_user_response_data.freezed.dart';
part 'api_user_response_data.g.dart';

@freezed
class ApiUserResponseData with _$ApiUserResponseData {
  const factory ApiUserResponseData({
    @JsonKey(name: 'user') ApiUserData? userData,
  }) = _ApiUserResponseData;

  factory ApiUserResponseData.fromJson(Map<String, dynamic> json) =>
      _$ApiUserResponseDataFromJson(json);
}
