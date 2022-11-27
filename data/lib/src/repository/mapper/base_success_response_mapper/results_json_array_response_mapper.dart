import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../model/base_data/results_response.dart';
import '../base/base_success_response_mapper.dart';

@Injectable()
class ResultsJsonArrayResponseMapper<T>
    extends BaseSuccessResponseMapper<T, ResultsListResponse<T>> {
  @override
  // ignore: avoid-dynamic
  ResultsListResponse<T> map(dynamic response, Decoder<T>? decoder) {
    return decoder != null && response is Map<String, dynamic>
        ? ResultsListResponse.fromJson(response, (json) => decoder(json))
        : ResultsListResponse<T>(results: response);
  }
}
