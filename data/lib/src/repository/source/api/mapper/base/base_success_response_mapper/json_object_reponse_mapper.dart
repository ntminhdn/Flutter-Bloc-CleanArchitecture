import 'package:shared/shared.dart';

import '../../../../../../../data.dart';

class JsonObjectResponseMapper<T extends Object> extends BaseSuccessResponseMapper<T, T> {
  @override
  // ignore: avoid-dynamic
  T? mapToDataModel({
    required dynamic response,
    Decoder<T>? decoder,
  }) {
    return decoder != null && response is Map<String, dynamic> ? decoder(response) : null;
  }
}
