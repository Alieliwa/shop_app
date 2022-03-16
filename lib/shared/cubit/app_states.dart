import 'package:medica_zone/models/login/login_model.dart';

abstract class AppStates {}

class InitialAppState extends AppStates {}

class ChangeAppState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates{}

//HOME DATA
class AppLoadingHomeDataState extends AppStates{}
class AppSeccessHomeDataState extends AppStates{}
class AppErrorHomeDataState extends AppStates{}

//CATEGORIES DATA
class AppLoadingcategoriesDataState extends AppStates{}
class AppSeccesscategoriesDataState extends AppStates{}
class AppErrorcategoriesDataState extends AppStates{
  final String? error;
  AppErrorcategoriesDataState(this.error);
}


class AppSeccessFavoritesDataState extends AppStates{}
class AppErrorFavoritesDataState extends AppStates{
  final String? error;
  AppErrorFavoritesDataState(this.error);
}


class AppLoadingGetFavDataState extends AppStates{}
class AppSeccessGetFavDataState extends AppStates{}
class AppErrorGetFavDataState extends AppStates{}

class AppLoadingGetUserDataState extends AppStates{}
class AppSeccessGetUserDataState extends AppStates{
  final LoginModel loginModel;

  AppSeccessGetUserDataState(this.loginModel);

}
class AppErrorGetUserDataState extends AppStates{}

class AppLoadinUpdateDataState extends AppStates{}
class AppSeccessUpdateDataState extends AppStates{

  final LoginModel loginModel;

  AppSeccessUpdateDataState(this.loginModel);

}
class AppErrorUpdateDataState extends AppStates{}