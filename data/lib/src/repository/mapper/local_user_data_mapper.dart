import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../model/local_user_data.dart';
import 'base/base_data_mapper.dart';
import 'gender_data_mapper.dart';
import 'local_image_url_data_mapper.dart';

@Injectable()
class LocalUserDataMapper extends BaseDataMapper<LocalUserData, User> with DataMapperMixin {
  LocalUserDataMapper(
    this._genderDataMapper,
    this._localImageUrlDataMapper,
  );

  final GenderDataMapper _genderDataMapper;
  final LocalImageUrlDataMapper _localImageUrlDataMapper;

  @override
  User mapToEntity(LocalUserData? data) {
    return User(
      id: data?.id ?? -1,
      email: data?.email ?? '',
      money: BigDecimal.tryParse(data?.money) ?? BigDecimal.zero,
      birthday:
          data?.birthday != null ? DateTime.fromMillisecondsSinceEpoch(data!.birthday!) : null,
      avatar: _localImageUrlDataMapper.mapToEntity(data?.avatar.target),
      photos: _localImageUrlDataMapper.mapToListEntity(data?.photos),
      gender: _genderDataMapper.mapToEntity(data?.gender),
    );
  }

  @override
  LocalUserData mapToData(User entity) {
    return LocalUserData(
      email: entity.email,
      money: entity.money.toString(),
      birthday: entity.birthday?.millisecondsSinceEpoch,
      gender: _genderDataMapper.mapToData(entity.gender),
    )
      ..avatar.target = _localImageUrlDataMapper.mapToData(entity.avatar)
      ..photos.addAll(_localImageUrlDataMapper.mapToListData(entity.photos));
  }
}
