import 'package:shared/shared.dart';

import '../base_error_response_mapper/firebase_storage_error_response_mapper.dart';
import '../base_error_response_mapper/goong_error_response_mapper.dart';
import '../base_error_response_mapper/json_array_error_response_mapper.dart';
import '../base_error_response_mapper/json_object_error_response_mapper.dart';
import '../base_error_response_mapper/line_error_response_mapper.dart';
import '../base_error_response_mapper/twitter_error_response_mapper.dart';
import 'base_data_mapper.dart';

abstract class BaseErrorResponseMapper<T> extends BaseDataMapper<T, ServerError> {
  const BaseErrorResponseMapper();

  factory BaseErrorResponseMapper.fromType(ErrorResponseMapperType type) {
    switch (type) {
      case ErrorResponseMapperType.jsonObject:
        return JsonObjectErrorResponseMapper() as BaseErrorResponseMapper<T>;
      case ErrorResponseMapperType.jsonArray:
        return JsonArrayErrorResponseMapper() as BaseErrorResponseMapper<T>;
      case ErrorResponseMapperType.line:
        return LineErrorResponseMapper() as BaseErrorResponseMapper<T>;
      case ErrorResponseMapperType.twitter:
        return TwitterErrorResponseMapper() as BaseErrorResponseMapper<T>;
      case ErrorResponseMapperType.goong:
        return GoongErrorResponseMapper() as BaseErrorResponseMapper<T>;
      case ErrorResponseMapperType.firebaseStorage:
        return FirebaseStorageErrorResponseMapper() as BaseErrorResponseMapper<T>;
    }
  }
}
