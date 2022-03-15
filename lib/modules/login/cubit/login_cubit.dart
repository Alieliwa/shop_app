import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone/models/login/login_model.dart';
import 'package:medica_zone/modules/login/cubit/login_state.dart';
import 'package:medica_zone/shared/network/end_points.dart';
import 'package:medica_zone/shared/network/remote/dio_helper.dart';

class MedicaLoginCubit extends Cubit<MedicaLoginStates> {
  MedicaLoginCubit() : super(MedicaLoginInitialState());

  static MedicaLoginCubit get(context) => BlocProvider.of(context);
  late LoginModel loginModel;
  bool passwordVisible = true;
  IconData suffix = Icons.visibility;

  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    suffix = passwordVisible ? Icons.visibility : Icons.visibility_off;
    emit(MedicaLoginChangePasswordVisibilityState());
  }

  void userLogin({
    @required String? email,
    @required String? password,
  }) {
    emit(MedicaLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {"email": email, "password": password},
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(MedicaLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(MedicaLoginFailureState(error.toString()));
    });
  }
}
