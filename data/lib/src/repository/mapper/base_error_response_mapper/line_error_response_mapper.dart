import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../mapper/base/base_error_response_mapper.dart';

@Injectable()
class LineErrorResponseMapper extends BaseErrorResponseMapper<Map<String, dynamic>> {
  @override
  ServerError mapToEntity(Map<String, dynamic>? json) {
    return ServerError(generalMessage: json?['error_description']);
  }
}
