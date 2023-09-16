import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../app.dart';

class MyApp extends StatefulWidget {
  const MyApp({required this.initialResource, super.key});

  final LoadInitialResourceOutput initialResource;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends BasePageState<MyApp, AppBloc> {
  final _appRouter = GetIt.instance.get<AppRouter>();

  @override
  bool get isAppWidget => true;

  @override
  void initState() {
    super.initState();
    bloc.add(const AppInitiated());
  }

  @override
  Widget buildPage(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(DeviceConstants.designDeviceWidth, DeviceConstants.designDeviceHeight),
      builder: (context, _) => BlocBuilder<AppBloc, AppState>(
        buildWhen: (previous, current) =>
            previous.isDarkTheme != current.isDarkTheme ||
            previous.languageCode != current.languageCode,
        builder: (context, state) {
          return MaterialApp.router(
            builder: (context, child) {
              final MediaQueryData data = MediaQuery.of(context);

              return MediaQuery(
                data: data.copyWith(textScaleFactor: 1.0),
                child: child ?? const SizedBox.shrink(),
              );
            },
            routerDelegate: _appRouter.delegate(
              deepLinkBuilder: (deepLink) {
                return DeepLink(_mapRouteToPageRouteInfo());
              },
              navigatorObservers: () => [AppNavigatorObserver()],
            ),
            routeInformationParser: _appRouter.defaultRouteParser(),
            title: UiConstants.materialAppTitle,
            color: UiConstants.taskMenuMaterialAppColor,
            themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
            theme: lightTheme,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) =>
                supportedLocales.contains(locale)
                    ? locale
                    : const Locale(LocaleConstants.defaultLocale),
            locale: Locale(state.languageCode.localeCode),
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }

  List<PageRouteInfo> _mapRouteToPageRouteInfo() {
    return widget.initialResource.initialRoutes.map<PageRouteInfo>((e) {
      switch (e) {
        case AppRoute.login:
          return const LoginRoute();
        case AppRoute.main:
          return const MainRoute();
      }
    }).toList(growable: false);
  }
}
