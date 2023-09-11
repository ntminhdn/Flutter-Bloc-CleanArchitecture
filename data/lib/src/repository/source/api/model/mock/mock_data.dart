import 'package:freezed_annotation/freezed_annotation.dart';

part 'mock_data.freezed.dart';
part 'mock_data.g.dart';

/// This file is used to generate mock data for testing.
@freezed
@visibleForTesting
class MockData with _$MockData {
  const MockData._();

  const factory MockData({
    @JsonKey(name: 'uid') int? id,
    @JsonKey(name: 'email') String? email,
  }) = _MockData;

  factory MockData.fromJson(Map<String, dynamic> json) => _$MockDataFromJson(json);
}

@freezed
class MockData2 with _$MockData2 {
  const MockData2._();

  const factory MockData2({
    @JsonKey(name: 'mock_data') MockData? mockData,
  }) = _MockData2;

  factory MockData2.fromJson(Map<String, dynamic> json) => _$MockData2FromJson(json);
}
