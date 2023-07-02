import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_url.freezed.dart';
part 'image_url.g.dart';

@freezed
class ImageUrl with _$ImageUrl {
  const factory ImageUrl({
    @Default('') String origin,
    @Default('') String sm,
    @Default('') String md,
    @Default('') String lg,
  }) = _ImageUrl;

  factory ImageUrl.fromJson(Map<String, dynamic> json) => _$ImageUrlFromJson(json);
}
