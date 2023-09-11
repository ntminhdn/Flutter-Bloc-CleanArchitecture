import 'package:dartx/dartx.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

import 'package:shared/shared.dart';
import '../../../../../../../data.dart';

@Injectable()
class ServerGraphQLErrorMapper extends BaseErrorResponseMapper<OperationException> {
  const ServerGraphQLErrorMapper();

  @override
  ServerError mapToServerError(OperationException? data) {
    return ServerError(
      generalMessage: data?.graphqlErrors.firstOrNull?.message,
      generalServerErrorId: data?.graphqlErrors.firstOrNull?.extensions?['code'] as String?,
      errors: data?.graphqlErrors
              .map((e) => ServerErrorDetail(
                    message: e.message,
                    serverErrorId: e.extensions?['code'] as String? ?? '',
                  ))
              .toList(growable: false) ??
          [],
    );
  }
}
