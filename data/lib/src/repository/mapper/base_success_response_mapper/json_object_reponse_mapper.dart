import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../base/base_success_response_mapper.dart';

@Injectable()
class JsonObjectResponseMapper<T> extends BaseSuccessResponseMapper<T, T> {
  @override
  // ignore: avoid-dynamic
  T map(dynamic response, Decoder<T>? decoder) {
    return decoder != null && response is Map<String, dynamic> ? decoder(response) : response;
  }
}
