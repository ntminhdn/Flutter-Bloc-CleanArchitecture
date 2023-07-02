import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/register_account.dart';

class RegisterAccountPage extends StatefulWidget {
  const RegisterAccountPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterAccountPageState();
  }
}

class _RegisterAccountPageState extends BasePageState<RegisterAccountPage, RegisterAccountBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const RegisterAccountPageInitiated());
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => navigator.push(AppRouteInfo.login()),
                child: Text(
                  'Login',
                  style: AppTextStyles.s14w400Primary(),
                ),
              ),
              InkWell(
                onTap: () => navigator.popUntilRoot(),
                child: Text(
                  'Pop until root',
                  style: AppTextStyles.s14w400Primary(),
                ),
              ),
              InkWell(
                onTap: () => navigator.popUntilRouteName(NavigationConstants.itemDetailName),
                child: Text(
                  'Pop until item detail',
                  style: AppTextStyles.s14w400Primary(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
