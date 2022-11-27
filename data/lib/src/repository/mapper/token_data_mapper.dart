import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../model/token_data.dart';
import 'base/base_data_mapper.dart';

@Injectable()
class TokenDataMapper extends BaseDataMapper<TokenData, Token> {
  @override
  Token mapToEntity(TokenData? data) {
    return Token(
      accessToken: data?.accessToken ?? '',
      refreshToken: data?.refreshToken ?? '',
    );
  }
}
