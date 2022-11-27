import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../model/base_data/records_response.dart';
import '../base/base_success_response_mapper.dart';

@Injectable()
class RecordsJsonArrayResponseMapper<T>
    extends BaseSuccessResponseMapper<T, RecordsListResponse<T>> {
  @override
  // ignore: avoid-dynamic
  RecordsListResponse<T> map(dynamic response, Decoder<T>? decoder) {
    return decoder != null && response is Map<String, dynamic>
        ? RecordsListResponse.fromJson(response, (json) => decoder(json))
        : RecordsListResponse<T>(records: response);
  }
}
