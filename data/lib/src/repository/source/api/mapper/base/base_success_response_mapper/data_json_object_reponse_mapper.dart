import 'package:injectable/injectable.dart';

import 'package:shared/shared.dart';
import '../../../../../../../data.dart';

@Injectable()
class DataJsonObjectResponseMapper<T> extends BaseSuccessResponseMapper<T, DataResponse<T>> {
  @override
  // ignore: avoid-dynamic
  DataResponse<T> mapToDataModel({
    required dynamic response,
    Decoder<T>? decoder,
  }) {
    return decoder != null && response is Map<String, dynamic>
        ? DataResponse.fromJson(response, (json) => decoder(json))
        : throw RemoteException(
            kind: RemoteExceptionKind.invalidSuccessResponseMapperType,
            rootException: '$response is not a JSONObject',
          );
  }
}
