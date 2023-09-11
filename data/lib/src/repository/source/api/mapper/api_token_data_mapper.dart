import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data.dart';

@Injectable()
class ApiTokenDataMapper extends BaseDataMapper<ApiTokenData, Token> {
  @override
  Token mapToEntity(ApiTokenData? data) {
    return Token(
      accessToken: data?.accessToken ?? Token.defaultAccessToken,
      refreshToken: data?.refreshToken ?? Token.defaultRefreshToken,
    );
  }
}
