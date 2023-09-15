import 'package:injectable/injectable.dart';

import 'package:shared/shared.dart';
import '../../../../../../../data.dart';

@Injectable()
// ignore: avoid-dynamic
class JsonArrayErrorResponseMapper extends BaseErrorResponseMapper<List<dynamic>> {
  @override
  // ignore: avoid-dynamic
  ServerError mapToServerError(List<dynamic>? data) {
    return ServerError(
      errors: data
              ?.map((jsonObject) => ServerErrorDetail(
                    serverStatusCode: jsonObject['code'] as int?,
                    message: jsonObject['message'] as String?,
                  ))
              .toList(growable: false) ??
          [],
    );
  }
}
