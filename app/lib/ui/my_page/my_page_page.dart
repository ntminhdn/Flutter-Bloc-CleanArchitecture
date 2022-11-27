import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import '../../app.dart';

class MyPagePage extends StatefulWidget {
  const MyPagePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyPagePageState();
  }
}

class _MyPagePageState extends BasePageState<MyPagePage, MyPageBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              BlocBuilder<AppBloc, AppState>(
                builder: (context, state) {
                  return SwitchListTile.adaptive(
                    title: Text(
                      S.current.darkTheme,
                      style: AppTextStyles.s14w400Primary(),
                    ),
                    tileColor: AppColors.current.primaryColor,
                    value: state.isDarkTheme,
                    onChanged: (isDarkTheme) => appBloc.add(
                      AppThemeChanged(isDarkTheme: isDarkTheme),
                    ),
                  );
                },
              ),
              BlocBuilder<AppBloc, AppState>(
                builder: (context, state) {
                  return SwitchListTile.adaptive(
                    title: Text(
                      S.current.japanese,
                      style: AppTextStyles.s14w400Primary(),
                    ),
                    tileColor: AppColors.current.primaryColor,
                    value: state.languageCode == LanguageCode.ja,
                    onChanged: (isJa) => appBloc.add(
                      AppLanguageChanged(languageCode: isJa ? LanguageCode.ja : LanguageCode.en),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
