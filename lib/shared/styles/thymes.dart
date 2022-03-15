import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medica_zone/shared/styles/colors.dart';

ThemeData light =  ThemeData(
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
);

ThemeData dark = ThemeData(
  inputDecorationTheme: const InputDecorationTheme(
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
        fontSize: 20.0),
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
);
