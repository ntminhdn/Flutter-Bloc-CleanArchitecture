import 'package:freezed_annotation/freezed_annotation.dart';

part 'records_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class RecordsListResponse<T> {
  RecordsListResponse({
    @JsonKey(name: 'records') this.records,
    @JsonKey(name: 'page') this.page,
    @JsonKey(name: 'offset') this.offset,
    @JsonKey(name: 'total') this.total,
    @JsonKey(name: 'next') this.next,
    @JsonKey(name: 'prev') this.prev,
  });

  // ignore: avoid-dynamic
  factory RecordsListResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) =>
      _$RecordsListResponseFromJson(json, fromJsonT);

  final List<T>? records;
  final int? page;
  final int? offset;
  final int? total;
  final int? next;
  final int? prev;
}
