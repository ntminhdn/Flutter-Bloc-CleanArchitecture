import 'package:shared/shared.dart';

import '../base_success_response_mapper/data_json_array_response_mapper.dart';
import '../base_success_response_mapper/data_json_object_reponse_mapper.dart';
import '../base_success_response_mapper/json_array_response_mapper.dart';
import '../base_success_response_mapper/json_object_reponse_mapper.dart';
import '../base_success_response_mapper/records_json_array_response_mapper.dart';
import '../base_success_response_mapper/results_json_array_response_mapper.dart';

abstract class BaseSuccessResponseMapper<I, O> {
  const BaseSuccessResponseMapper();

  factory BaseSuccessResponseMapper.fromType(SuccessResponseMapperType type) {
    switch (type) {
      case SuccessResponseMapperType.dataJsonObject:
        return DataJsonObjectResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
      case SuccessResponseMapperType.dataJsonArray:
        return DataJsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
      case SuccessResponseMapperType.jsonObject:
        return JsonObjectResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
      case SuccessResponseMapperType.jsonArray:
        return JsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
      case SuccessResponseMapperType.recordsJsonArray:
        return RecordsJsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
      case SuccessResponseMapperType.resultsJsonArray:
        return ResultsJsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
    }
  }

  // ignore: avoid-dynamic
  O map(dynamic response, Decoder<I>? decoder);
}
