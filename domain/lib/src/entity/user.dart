import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../domain.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    @Default(User.defaultId) int id,
    @Default(User.defaultEmail) String email,
    @Default(User.defaultMoney) BigDecimal money,
    @Default(User.defaultBirthday) DateTime? birthday,
    @Default(User.defaultAvatar) ImageUrl avatar,
    @Default(User.defaultPhotos) List<ImageUrl> photos,
    @Default(User.defaultGender) Gender gender,
  }) = _User;

  static const defaultId = 0;
  static const defaultEmail = '';
  static const defaultMoney = BigDecimal.zero;
  static const DateTime? defaultBirthday = null;
  static const defaultAvatar = ImageUrl();
  static const defaultPhotos = <ImageUrl>[];
  static const defaultGender = Gender.defaultValue;
}
