import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../domain.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    @Default(0) int id,
    @Default('') String email,
    @Default(BigDecimal.zero) BigDecimal money,
    DateTime? birthday,
    @Default(ImageUrl()) ImageUrl avatar,
    @Default(<ImageUrl>[]) List<ImageUrl> photos,
    @Default(Gender.unknown) Gender gender,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
