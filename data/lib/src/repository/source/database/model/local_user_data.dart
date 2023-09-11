import 'package:objectbox/objectbox.dart';

import 'local_image_url_data.dart';

@Entity()
class LocalUserData {
  LocalUserData({
    this.email,
    this.money,
    this.gender,
    this.birthday,
  });

  @Id()
  int? id;
  String? email;
  String? money;
  int? gender;
  int? birthday;

  final avatar = ToOne<LocalImageUrlData>();
  final photos = ToMany<LocalImageUrlData>();

  @override
  int get hashCode {
    return id.hashCode ^ email.hashCode ^ money.hashCode ^ gender.hashCode ^ birthday.hashCode;
  }

  @override
  String toString() {
    return 'LocalUserData(id: $id, email: $email, money: $money, gender: $gender, birthday: $birthday)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is LocalUserData &&
        other.id == id &&
        other.email == email &&
        other.money == money &&
        other.gender == gender &&
        other.birthday == birthday;
  }
}
