import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../model/base_data/data_response.dart';
import '../base/base_success_response_mapper.dart';

@Injectable()
class DataJsonObjectResponseMapper<T> extends BaseSuccessResponseMapper<T, DataResponse<T>> {
  @override
  // ignore: avoid-dynamic
  DataResponse<T> map(dynamic response, Decoder<T>? decoder) {
    return decoder != null && response is Map<String, dynamic>
        ? DataResponse.fromJson(response, (json) => decoder(json))
        : DataResponse<T>(data: response);
  }
}
