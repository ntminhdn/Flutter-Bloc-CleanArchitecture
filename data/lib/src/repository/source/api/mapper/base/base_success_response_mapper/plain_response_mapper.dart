import 'package:shared/shared.dart';
import '../../../../../../../data.dart';

class PlainResponseMapper<T> extends BaseSuccessResponseMapper<T, T> {
  @override
  T mapToDataModel({
    required dynamic response,
    Decoder<T>? decoder,
  }) {
    assert(decoder == null);
    if (response is T) {
      return response;
    } else {
      throw RemoteException(
        kind: RemoteExceptionKind.invalidSuccessResponseMapperType,
        rootException: 'Response is not $T',
      );
    }
  }
}
