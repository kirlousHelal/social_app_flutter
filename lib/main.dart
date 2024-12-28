// import 'package:continuelearning/TODO%20APP/layout/home_layout.dart';

import 'package:continuelearning/SocialApp/cubit/cubit.dart';
import 'package:continuelearning/SocialApp/cubit/states.dart';
import 'package:continuelearning/SocialApp/layout/social_layout.dart';
import 'package:continuelearning/SocialApp/modules/login/login_screen.dart';
import 'package:continuelearning/SocialApp/shared/constants/constants.dart';
import 'package:continuelearning/SocialApp/shared/network/local/cache_helper.dart';
import 'package:continuelearning/SocialApp/shared/network/remote/dio_helper.dart';
import 'package:continuelearning/SocialApp/shared/styles/themes.dart';
import 'package:continuelearning/bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();

  DioHelper.init();
  await CacheHelper.init();

  // var tokenObject = await CacheHelper.getData(key: "token");
  // token = tokenObject is String ? tokenObject : "No Token";

  // var valueOnBoarding = await CacheHelper.getData(key: "onboarding");
  // bool onBoard = valueOnBoarding is bool ? valueOnBoarding : false;
  //
  // var valueLogin = await CacheHelper.getData(key: "login");
  // bool login = valueLogin is bool ? valueLogin : false;
  // Widget startScreen = OnBoardScreen();

  // if (onBoard) {
  //   startScreen = LoginScreen();
  //   if (login) {
  //     startScreen = const ShopLayout();
  //   }
  // }

  Widget startScreen = LoginScreen();
  if (CacheHelper.isExist(key: "uId")!) {
    uId = CacheHelper.getData(key: "uId");
    print(uId);
    startScreen = const SocialLayout();
  }

  runApp(MyApp(startScreen: startScreen));
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  final Widget startScreen;

  const MyApp({
    required this.startScreen,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SocialCubit(),
        child: BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              theme: lightTheme(),
              darkTheme: darkTheme(),
              // themeMode: ThemeMode.dark,
              home: Builder(builder: (context) {
                return startScreen;
              }),
              debugShowCheckedModeBanner: false,
            );
          },
        ));
  }
}
