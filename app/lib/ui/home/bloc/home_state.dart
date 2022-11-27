import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState extends BaseBlocState with _$HomeState {
  factory HomeState({
    @Default(LoadMoreOutput<User>(data: <User>[])) LoadMoreOutput<User> users,
    @Default(false) bool isShimmerLoading,
    AppException? loadUsersException,
  }) = _HomeState;
}
