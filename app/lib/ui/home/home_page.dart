import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/home.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends BasePageState<HomePage, HomeBloc> {
  late final _pagingController = CommonPagingController<User>()..disposeBy(disposeBag);

  @override
  void initState() {
    super.initState();
    bloc.add(const HomePageInitiated());
    _pagingController.listen(
      onLoadMore: () => bloc.add(const UserLoadMore()),
    );
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) => previous.users != current.users,
          listener: (context, state) {
            _pagingController.appendLoadMoreOutput(state.users);
          },
        ),
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) =>
              previous.loadUsersException != current.loadUsersException,
          listener: (context, state) {
            _pagingController.error = state.loadUsersException;
          },
        ),
      ],
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              previous.users != current.users ||
              previous.isShimmerLoading != current.isShimmerLoading,
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () {
                final completer = Completer<void>();
                bloc.add(HomePageRefreshed(completer: completer));

                return completer.future;
              },
              child: state.isShimmerLoading && state.users.data.isEmpty
                  ? const _ListViewLoader()
                  : CommonPagedListView<User>(
                      pagingController: _pagingController,
                      itemBuilder: (context, user, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimens.d8.responsive(),
                            vertical: Dimens.d4.responsive(),
                          ),
                          child: ShimmerLoading(
                            isLoading: state.isShimmerLoading,
                            loadingWidget: const _LoadingItem(),
                            child: GestureDetector(
                              onTap: () async {
                                await navigator.push(AppRouteInfo.itemDetail(user));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.current.primaryColor,
                                  borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
                                ),
                                width: double.infinity,
                                height: Dimens.d60.responsive(),
                                child: Text(
                                  user.email,
                                  style: AppTextStyles.s14w400Primary(),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            );
          },
        ),
      ),
    );
  }
}

class _LoadingItem extends StatelessWidget {
  const _LoadingItem();

  @override
  Widget build(BuildContext context) {
    return RounedRectangleShimmer(
      width: double.infinity,
      height: Dimens.d60.responsive(),
    );
  }
}

/// Because [PagedListView] does not expose the [itemCount] property, itemCount = 0 on the first load and thus the Shimmer loading effect can not work. We need to create a fake ListView for the first load.
class _ListViewLoader extends StatelessWidget {
  const _ListViewLoader();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: UiConstants.shimmerItemCount,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.d8.responsive(),
          vertical: Dimens.d4.responsive(),
        ),
        child: const ShimmerLoading(
          loadingWidget: _LoadingItem(),
          isLoading: true,
          child: _LoadingItem(),
        ),
      ),
    );
  }
}
