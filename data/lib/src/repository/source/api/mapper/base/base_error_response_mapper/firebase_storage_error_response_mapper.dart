import 'package:injectable/injectable.dart';

import 'package:shared/shared.dart';
import '../../../../../../../data.dart';

@Injectable()
class FirebaseStorageErrorResponseMapper extends BaseErrorResponseMapper<Map<String, dynamic>> {
  @override
  ServerError mapToServerError(Map<String, dynamic>? json) {
    return ServerError(
      generalServerStatusCode: json?['error']['code'] as int?,
      generalMessage: json?['error']['message'] as String?,
    );
  }
}
