import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data.dart';

@Injectable()
class PreferenceUserDataMapper extends BaseDataMapper<PreferenceUserData, User>
    with DataMapperMixin {
  @override
  User mapToEntity(PreferenceUserData? data) {
    return User(
      id: data?.id ?? User.defaultId,
      email: data?.email ?? User.defaultEmail,
    );
  }

  @override
  PreferenceUserData mapToData(User entity) {
    return PreferenceUserData(
      id: entity.id,
      email: entity.email,
    );
  }
}
