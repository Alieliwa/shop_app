import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone/models/Change_Fav_models/change_favorites.dart';
import 'package:medica_zone/models/Get_Fav_Model/get_fav_model.dart';
import 'package:medica_zone/models/categories_models/categories_models.dart';
import 'package:medica_zone/models/home_models/home_models.dart';
import 'package:medica_zone/models/login/login_model.dart';
import 'package:medica_zone/modules/Cart_Screen/cart_screen.dart';
import 'package:medica_zone/modules/Screens_bottom_navigation/category_screen.dart';
import 'package:medica_zone/modules/Screens_bottom_navigation/favorite_screen.dart';
import 'package:medica_zone/modules/Screens_bottom_navigation/homeBottomScreen.dart';
import 'package:medica_zone/modules/Screens_bottom_navigation/person_screen.dart';
import 'package:medica_zone/modules/Screens_bottom_navigation/hot_dealse_Screen.dart';
import 'package:medica_zone/shared/components/constants.dart';
import 'package:medica_zone/shared/network/end_points.dart';
import 'package:medica_zone/shared/network/local/cache_helper.dart';
import 'package:medica_zone/shared/network/remote/dio_helper.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomitems =  [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: 'Category'),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Wishlist'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  List<Widget> Screens = [
    HomeBottomScreen(),
    CategoriesScreen(),
    CartScreen(),
    FavoriteScreen(),
    PersonScreen(),
  ];

  List<String> titles = [
    'Home Screen',
    'Category Screen',
    'Hot DealesScreen',
    'Cart Screen',
    'Person Screen',
  ];
  void ChangeIndx(int index) {

    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  bool isDark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppState());
    } else {
      isDark = !isDark;
      CacheHelper.putBooleanData(key: "isDark", value: isDark).then((value) {
        emit(ChangeAppState());
      });
    }
  }



  HomeModel? homeModel;

  Map<int,bool>? favorite = {};
  void getHomeData() {
    emit(AppLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      authToken: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
    //  printFullText(homeModel!.data.toString());

      homeModel!.data!.products.forEach((element) {
        favorite!.addAll({
          element.id! : element.inFavorites!,
        });
      });

      print(favorite.toString());

      emit(AppSeccessHomeDataState());
    }).catchError((error) {
      print("Errors ${error}");
      emit(AppErrorHomeDataState());
    });
  }


  CategoriesModel? categoriesModel;
  void getCategoryData() {
    emit(AppLoadingcategoriesDataState());
    DioHelper.getData(
      url: CATEGORIES,
      authToken: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(AppSeccesscategoriesDataState());
    }).catchError((error) {
      print("Errors ${error}");
      emit(AppErrorcategoriesDataState(error));
    });
  }

  GetFavModel? getFavModel;
  void getFavData() {
    emit(AppLoadingGetFavDataState());
    DioHelper.getData(
      url: FAVORITES,
      authToken: token,
    ).then((value) {
      getFavModel = GetFavModel.fromJson(value.data);
      emit(AppSeccessGetFavDataState());
    }).catchError((error) {
      print("Errors ${error}");
      emit(AppErrorGetFavDataState());
    });
  }



  ChangeFavorites? changefavorites;
  void changeFavorites(int ProductId){

    favorite![ProductId] = !favorite![ProductId]!;

    emit(AppSeccessFavoritesDataState());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : ProductId
        },
        authToken: token
    ).then((value) {
      changefavorites = ChangeFavorites.fromJson(value.data);

      print(value.data);

      if(!changefavorites!.status!){
        favorite![ProductId] = !favorite![ProductId]!;
      }else{
        getFavData();
      }

      emit(AppSeccessFavoritesDataState());

    }).catchError((error){
      favorite![ProductId] = !favorite![ProductId]!;
      emit(AppErrorFavoritesDataState(error));
    });
  }


  LoginModel? userData;
  void getUserData() {
    emit(AppLoadingGetUserDataState());
    DioHelper.getData(
      url: PROFILE,
      authToken: token,
    ).then((value) {
      userData = LoginModel.fromJson(value.data);
      // print(userData!.data!.name);
      emit(AppSeccessGetUserDataState(userData!));
    }).catchError((error) {
      print("Errors ${error}");
      emit(AppErrorGetUserDataState());
    });
  }

  LoginModel? UpdateData;
  void getUpdateData({
  required String name,
  required String email,
  required String phone,

}) {
    emit(AppLoadinUpdateDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      authToken: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      UpdateData = LoginModel.fromJson(value.data);
      // print(userData!.data!.name);
      emit(AppSeccessUpdateDataState(UpdateData!));
    }).catchError((error) {
      print("Errors ${error}");
      emit(AppErrorUpdateDataState());
    });
  }

}
