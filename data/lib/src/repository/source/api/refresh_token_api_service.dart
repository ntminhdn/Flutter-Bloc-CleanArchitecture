import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../../../data.dart';

@LazySingleton()
class RefreshTokenApiService {
  RefreshTokenApiService(this._refreshTokenApiClient);

  final RefreshTokenApiClient _refreshTokenApiClient;

  Future<DataResponse<RefreshTokenData>> refreshToken(String refreshToken) async {
    try {
      final respone = await _refreshTokenApiClient.request(
        method: RestMethod.post,
        path: '/v1/auth/refresh',
        decoder: RefreshTokenData.fromJson,
      );

      return respone;
    } catch (e) {
      if (e is RemoteException &&
          (e.kind == RemoteExceptionKind.serverDefined ||
              e.kind == RemoteExceptionKind.serverUndefined)) {
        throw const RemoteException(kind: RemoteExceptionKind.refreshTokenFailed);
      }

      rethrow;
    }
  }
}
