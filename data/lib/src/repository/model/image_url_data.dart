import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_url_data.freezed.dart';
part 'image_url_data.g.dart';

@freezed
class ImageUrlData with _$ImageUrlData {
  const factory ImageUrlData({
    @JsonKey(name: 'origin') String? origin,
    @JsonKey(name: 'sm') String? sm,
    @JsonKey(name: 'md') String? md,
    @JsonKey(name: 'lg') String? lg,
  }) = _ImageUrlData;

  const ImageUrlData._();

  factory ImageUrlData.fromJson(Map<String, dynamic> json) => _$ImageUrlDataFromJson(json);
}
