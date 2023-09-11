import 'package:freezed_annotation/freezed_annotation.dart';

part 'results_response.freezed.dart';
part 'results_response.g.dart';

@Freezed(genericArgumentFactories: true)
class ResultsListResponse<T> with _$ResultsListResponse<T> {
  const factory ResultsListResponse({
    @JsonKey(name: 'results') List<T>? results,
  }) = _ResultsListResponse;

  factory ResultsListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ResultsListResponseFromJson(json, fromJsonT);
}
