import 'package:dartx/dartx.dart';
import 'package:injectable/injectable.dart';

import 'package:shared/shared.dart';
import '../../../../../../../data.dart';

@Injectable()
class TwitterErrorResponseMapper extends BaseErrorResponseMapper<Map<String, dynamic>> {
  @override
  ServerError mapToServerError(Map<String, dynamic>? json) {
    return ServerError(
      generalMessage:
          // ignore: avoid-dynamic
          ((json?['errors'] as List<dynamic>?)?.firstOrNull as Map<String, dynamic>)['message']
                  as String? ??
              '',
    );
  }
}
