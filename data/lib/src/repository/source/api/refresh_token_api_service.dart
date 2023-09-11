import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../../data.dart';

@LazySingleton()
class RefreshTokenApiService {
  RefreshTokenApiService(this._refreshTokenApiClient);

  final RefreshTokenApiClient _refreshTokenApiClient;

  Future<DataResponse<ApiRefreshTokenData>?> refreshToken(String refreshToken) async {
    try {
      final respone = await _refreshTokenApiClient
          .request<ApiRefreshTokenData, DataResponse<ApiRefreshTokenData>>(
        method: RestMethod.post,
        path: '/v1/auth/refresh',
        decoder: (json) => ApiRefreshTokenData.fromJson(json as Map<String, dynamic>),
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
