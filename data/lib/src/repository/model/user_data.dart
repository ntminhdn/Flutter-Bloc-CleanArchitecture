import 'package:freezed_annotation/freezed_annotation.dart';

import 'image_url_data.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
class UserData with _$UserData {
  const UserData._();

  const factory UserData({
    @JsonKey(name: 'uid') int? id,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'birthday') String? birthday,
    @JsonKey(name: 'money') String? money,
    @JsonKey(name: 'avatar') ImageUrlData? avatar,
    @JsonKey(name: 'photos') List<ImageUrlData>? photos,
    @JsonKey(name: 'sex') int? gender,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
}
