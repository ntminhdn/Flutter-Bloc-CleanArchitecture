import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../model/preference_user_data.dart';
import 'base/base_data_mapper.dart';

@Injectable()
class PreferenceUserDataMapper extends BaseDataMapper<PreferenceUserData, User>
    with DataMapperMixin {
  @override
  User mapToEntity(PreferenceUserData? data) {
    return User(
      id: data?.id ?? -1,
      email: data?.email ?? '',
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
