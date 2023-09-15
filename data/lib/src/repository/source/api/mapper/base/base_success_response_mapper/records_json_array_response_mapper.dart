import 'package:injectable/injectable.dart';

import 'package:shared/shared.dart';
import '../../../../../../../data.dart';

@Injectable()
class RecordsJsonArrayResponseMapper<T>
    extends BaseSuccessResponseMapper<T, RecordsListResponse<T>> {
  @override
  // ignore: avoid-dynamic
  RecordsListResponse<T> mapToDataModel({
    required dynamic response,
    Decoder<T>? decoder,
  }) {
    return decoder != null && response is Map<String, dynamic>
        ? RecordsListResponse.fromJson(response, (json) => decoder(json))
        : throw RemoteException(
            kind: RemoteExceptionKind.invalidSuccessResponseMapperType,
            rootException: '$response is not a JSONObject',
          );
  }
}
