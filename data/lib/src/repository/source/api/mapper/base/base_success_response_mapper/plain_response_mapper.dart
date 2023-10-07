import 'package:shared/shared.dart';

import '../../../../../../../data.dart';

class PlainResponseMapper<T extends Object> extends BaseSuccessResponseMapper<T, T> {
  @override
  T? mapToDataModel({
    required dynamic response,
    Decoder<T>? decoder,
  }) {
    assert(decoder == null);

    return response is T ? response : null;
  }
}
