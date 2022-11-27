import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';

part 'get_users_use_case.freezed.dart';

@Injectable()
class GetUsersUseCase extends BaseLoadMoreUseCase<GetUsersInput, User> {
  GetUsersUseCase(this._repository) : super(initPage: PagingConstants.initialPage);

  final Repository _repository;

  @protected
  @override
  Future<PagedList<User>> buildUseCase(GetUsersInput input) {
    return _repository.getUsers(
      page: page,
      limit: PagingConstants.itemsPerPage,
    );
  }
}

@freezed
class GetUsersInput extends BaseInput with _$GetUsersInput {
  const factory GetUsersInput() = _GetUsersInput;
}
