import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../model/local_image_url_data.dart';
import 'base/base_data_mapper.dart';

@Injectable()
class LocalImageUrlDataMapper extends BaseDataMapper<LocalImageUrlData, ImageUrl>
    with DataMapperMixin {
  @override
  ImageUrl mapToEntity(LocalImageUrlData? data) {
    return ImageUrl(
      origin: data?.origin ?? '',
      sm: data?.sm ?? '',
      md: data?.md ?? '',
      lg: data?.lg ?? '',
    );
  }

  @override
  LocalImageUrlData mapToData(ImageUrl entity) {
    return LocalImageUrlData(
      origin: entity.origin,
      lg: entity.lg,
      md: entity.md,
      sm: entity.sm,
    );
  }
}
