import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import '../../app.dart';
import 'bloc/search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends BasePageState<SearchPage, SearchBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.current.primaryColor),
          ),
          onPressed: () {
            navigator.push(AppRouteInfo.login(), useRootNavigator: true);
          },
          child: Text(
            S.current.login,
            style: AppTextStyles.s14w400Primary(),
          ),
        ),
      ),
    );
  }
}
