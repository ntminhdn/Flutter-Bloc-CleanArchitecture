import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'home.dart';

@Injectable()
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc(this._getUsersUseCase) : super(HomeState()) {
    on<HomePageInitiated>(
      _onHomePageInitiated,
      transformer: log(),
    );

    on<UserLoadMore>(
      _onUserLoadMore,
      transformer: log(),
    );

    on<HomePageRefreshed>(
      _onHomePageRefreshed,
      transformer: log(),
    );
  }
  final GetUsersUseCase _getUsersUseCase;

  FutureOr<void> _onHomePageInitiated(HomePageInitiated event, Emitter<HomeState> emit) async {
    await _getUsers(
      emit: emit,
      isInitialLoad: true,
      doOnSubscribe: () async => emit(state.copyWith(isShimmerLoading: true)),
      doOnSuccessOrError: () async => emit(state.copyWith(isShimmerLoading: false)),
    );
  }

  FutureOr<void> _onUserLoadMore(UserLoadMore event, Emitter<HomeState> emit) async {
    await _getUsers(
      emit: emit,
      isInitialLoad: false,
    );
  }

  FutureOr<void> _onHomePageRefreshed(HomePageRefreshed event, Emitter<HomeState> emit) async {
    await _getUsers(
      emit: emit,
      isInitialLoad: true,
      doOnSubscribe: () async => emit(state.copyWith(isShimmerLoading: true)),
      doOnSuccessOrError: () async {
        emit(state.copyWith(isShimmerLoading: false));

        if (!event.completer.isCompleted) {
          event.completer.complete();
        }
      },
    );
  }

  Future<void> _getUsers({
    required Emitter<HomeState> emit,
    required bool isInitialLoad,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
  }) async {
    return runBlocCatching(
      action: () async {
        emit(state.copyWith(loadUsersException: null));
        final output = await _getUsersUseCase.execute(const GetUsersInput(), isInitialLoad);
        emit(state.copyWith(users: output));
      },
      doOnError: (e) async {
        emit(state.copyWith(loadUsersException: e));
      },
      doOnSubscribe: doOnSubscribe,
      doOnSuccessOrError: doOnSuccessOrError,
      handleLoading: false,
      maxRetries: 3,
    );
  }
}
