import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_location.freezed.dart';

@freezed
class AppLocation with _$AppLocation {
  const AppLocation._();

  const factory AppLocation({
    double? lat,
    double? lng,
    @Default('') String name,
  }) = _AppLocation;
}
