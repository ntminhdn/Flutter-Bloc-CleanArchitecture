import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../mapper/base/base_error_response_mapper.dart';

@Injectable()
class JsonObjectErrorResponseMapper extends BaseErrorResponseMapper<Map<String, dynamic>> {
  @override
  ServerError mapToEntity(Map<String, dynamic>? data) {
    return ServerError(
      generalServerStatusCode: data?['error']?['status_code'],
      generalServerErrorId: data?['error']?['error_code'],
      generalMessage: data?['error']?['message'],
    );
  }
}
