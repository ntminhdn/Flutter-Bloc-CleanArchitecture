import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_image_url_data.freezed.dart';
part 'api_image_url_data.g.dart';

@freezed
class ApiImageUrlData with _$ApiImageUrlData {
  const factory ApiImageUrlData({
    @JsonKey(name: 'origin') String? origin,
    @JsonKey(name: 'sm') String? sm,
    @JsonKey(name: 'md') String? md,
    @JsonKey(name: 'lg') String? lg,
  }) = _ApiImageUrlData;

  const ApiImageUrlData._();

  factory ApiImageUrlData.fromJson(Map<String, dynamic> json) => _$ApiImageUrlDataFromJson(json);
}
