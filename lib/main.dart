import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone/modules/home/home_screen.dart';
import 'package:medica_zone/modules/login/login.dart';
import 'package:medica_zone/modules/splash/splach_screen.dart';
import 'package:medica_zone/shared/components/constants.dart';
import 'package:medica_zone/shared/cubit/app_cubit.dart';
import 'package:medica_zone/shared/cubit/app_states.dart';
import 'package:medica_zone/shared/network/local/cache_helper.dart';
import 'package:medica_zone/shared/network/remote/dio_helper.dart';
import 'package:medica_zone/shared/styles/colors.dart';
import 'package:medica_zone/shared/styles/thymes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.int();
  await CacheHelper.int();
  bool? isDark = CacheHelper.getBooleanData(key: "isDark");
  Widget widget;
  bool? onBoarding = CacheHelper.getBooleanData(key: "onBoarding");
   token = CacheHelper.getBooleanData(key: "token");
   print("{token : $token}");

  if(onBoarding != null){
    if(token != null) {
      widget = HomeScreen();
    }else{
      widget = Login();
    }
  }else{
    widget = SplashScreen();

  }
  print(onBoarding);
  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        isDark: isDark,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  MyApp({this.isDark, this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getHomeData()
        ..getCategoryData()
        ..getFavData()
        ..getUserData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                iconColor: Colors.black,
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.blue,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                color: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
                iconTheme: IconThemeData(color: Colors.black),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: Colors.blue,
                  type: BottomNavigationBarType.fixed,
                  elevation: 30.0,
                  backgroundColor: Colors.white),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                prefixStyle: TextStyle(color: Colors.white) ,
                iconColor: Colors.grey,
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              scaffoldBackgroundColor: color,
              primarySwatch: Colors.blue,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                color: color,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),
                iconTheme: IconThemeData(color: Colors.white),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: color,
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.blue,
                type: BottomNavigationBarType.fixed,
                elevation: 30.0,
                backgroundColor: color,
                unselectedItemColor: Colors.grey,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white),
              ),
              // drawerTheme: DrawerThemeData(
              //   backgroundColor: color,
              //   elevation: 20,
              // )
            ),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home:startWidget,
          );
        },
      ),
    );
  }
}