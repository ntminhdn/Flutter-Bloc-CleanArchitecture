import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../../../../../data.dart';

@Injectable()
class GoongErrorResponseMapper extends BaseErrorResponseMapper<Map<String, dynamic>> {
  @override
  ServerError mapToServerError(Map<String, dynamic>? json) {
    return ServerError(
      generalMessage: json?['error']['message'] as String?,
    );
  }
}
