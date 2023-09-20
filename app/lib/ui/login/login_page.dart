import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import '../../app.dart';
import 'bloc/login.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends BasePageState<LoginPage, LoginBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: CommonAppBar(
        leadingIcon: navigator.canPopSelfOrChildren ? LeadingIcon.close : LeadingIcon.none,
        leadingIconColor: AppColors.current.secondaryColor,
        titleType: AppBarTitle.text,
        centerTitle: true,
        text: S.current.login,
        backgroundColor: AppColors.current.primaryColor,
        titleTextStyle: AppTextStyles.s14w400Primary(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Dimens.d16.responsive()),
          child: Column(
            children: [
              AppTextField(
                title: S.current.email,
                hintText: S.current.email,
                onChanged: (email) => bloc.add(EmailTextFieldChanged(email: email)),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: Dimens.d24.responsive()),
              AppTextField(
                title: S.current.password,
                hintText: S.current.password,
                onChanged: (pass) => bloc.add(PasswordTextFieldChanged(password: pass)),
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: Dimens.d15.responsive()),
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) => previous.onPageError != current.onPageError,
                builder: (_, state) => Text(
                  state.onPageError,
                  style: AppTextStyles.s14w400Secondary(),
                ),
              ),
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) =>
                    previous.isLoginButtonEnabled != current.isLoginButtonEnabled,
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.isLoginButtonEnabled
                        ? () => bloc.add(const LoginButtonPressed())
                        : null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.current.primaryColor
                          .withOpacity(state.isLoginButtonEnabled ? 1 : 0.5)),
                    ),
                    child: Text(
                      S.current.login,
                      style: AppTextStyles.s14w400Primary(),
                    ),
                  );
                },
              ),
              SizedBox(height: Dimens.d15.responsive()),
              ElevatedButton(
                onPressed: () => bloc.add(const FakeLoginButtonPressed()),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.current.primaryColor),
                ),
                child: Text(
                  S.current.fakeLogin,
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
