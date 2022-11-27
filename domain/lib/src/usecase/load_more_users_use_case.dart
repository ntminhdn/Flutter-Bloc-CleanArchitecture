import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';

part 'load_more_users_use_case.freezed.dart';

@Injectable()
class LoadMoreUsersUseCase extends BaseLoadMoreUseCase<LoadMoreUsersInput, User> {
  LoadMoreUsersUseCase(this._repository) : super(initPage: 2);

  final Repository _repository;

  @protected
  @override
  Future<PagedList<User>> buildUseCase(LoadMoreUsersInput input) {
    return _repository.getUsers(
      page: page,
      limit: PagingConstants.itemsPerPage,
    );
  }
}

@freezed
class LoadMoreUsersInput extends BaseInput with _$LoadMoreUsersInput {
  const factory LoadMoreUsersInput() = _LoadMoreUsersInput;
}
