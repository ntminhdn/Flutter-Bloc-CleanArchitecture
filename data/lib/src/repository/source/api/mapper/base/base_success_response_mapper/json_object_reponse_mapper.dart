import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../../../../../data.dart';

@Injectable()
class JsonObjectResponseMapper<T> extends BaseSuccessResponseMapper<T, T> {
  @override
  // ignore: avoid-dynamic
  T mapToDataModel({
    required dynamic response,
    Decoder<T>? decoder,
  }) {
    return decoder != null && response is Map<String, dynamic>
        ? decoder(response)
        : throw RemoteException(
            kind: RemoteExceptionKind.invalidSuccessResponseMapperType,
            rootException: '$response is not a JSONObject',
          );
  }
}
