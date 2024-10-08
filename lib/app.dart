import 'package:dawaa24/features/auth/domain/usecase/get_user_info_usecase.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'core/data/enums/auth_state.dart';
import 'core/data/network/network_Info.dart';
import 'core/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'core/presentation/blocs/theme_bloc/theme_state.dart';
import 'core/presentation/resources/theme/app_color_scheme.dart';
import 'core/presentation/resources/theme/app_theme.dart';
import 'di/injection.dart';
import 'features/auth/presentation/cubits/authentication/authentication_cubit.dart';
import 'features/main/presentation/cubits/main_page_cubit/main_page_cubit.dart';
import 'router.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int counter = 0;
  late NetworkInfo _networkInfo;

  GoRouter router = getRouter(AuthState.unKnown);

  @override
  void initState() {
    _networkInfo = GetIt.instance<NetworkInfo>();
    _networkInfo.monitorConnection(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => getIt<AuthenticationCubit>()),
        BlocProvider(create: (BuildContext context) => getIt<ThemeBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<MainPageCubit>()),
      ],
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listenWhen: (current, next) {
          return next.authState != AuthState.unKnown;
        },
        listener: (context, state) {
          String message = '';
          switch (state.authState) {
            case AuthState.authenticated:
              message = 'sign_in.Welcome'.tr();
              break;
            case AuthState.unAuthenticated:
              message = 'sign_in.You_login'.tr();
              break;
            case AuthState.unKnown:
              // TODO: Handle this case.
              break;
            case AuthState.notVerified:
              message = 'sign_in.complete_your_profile'.tr();
          }
          if (message.isNotEmpty) {
            Fluttertoast.showToast(
                msg: message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          router = getRouter(state.authState);
        },
        builder: (context, authStatus) => BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            var themeMode = ThemeMode.dark;
            if (state is ThemeInitial) {
              //TODO CHANGE THE THEME TO DARK

              themeMode = state.isDarkMode ? ThemeMode.light : ThemeMode.light;
              if (state.isDarkMode) {
                Theme.of(context).copyWith(brightness: Brightness.light);
              } else {
                Theme.of(context).copyWith(brightness: Brightness.light);
              }
              //TODO CHANGE THE THEME TO DARK
            } else if (state is DarkThemeState) {
              themeMode = ThemeMode.dark;
              //TODO CHANGE THE THEME TO DARK

              Theme.of(context).copyWith(brightness: Brightness.light);
            } else if (state is LightThemeState) {
              themeMode = ThemeMode.light;
              Theme.of(context).copyWith(brightness: Brightness.light);
            }
            timeago.setLocaleMessages('ar', timeago.ArMessages());

            return ScreenUtilInit(
              designSize: const Size(428, 926),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp.router(
                  routeInformationProvider: router.routeInformationProvider,
                  routeInformationParser: router.routeInformationParser,
                  routerDelegate: router.routerDelegate,
                  debugShowCheckedModeBanner: true,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  title: 'Dawaa 24',
                  theme: AppTheme(AppLightColorScheme()).getThemeData(context),
                  darkTheme:
                      AppTheme(AppDarkColorScheme()).getThemeData(context),
                  themeMode: themeMode,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
