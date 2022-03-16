import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone/models/login/login_model.dart';
import 'package:medica_zone/modules/login/cubit/login_state.dart';
import 'package:medica_zone/modules/register/cubitreg/register_state.dart';
import 'package:medica_zone/shared/network/end_points.dart';
import 'package:medica_zone/shared/network/remote/dio_helper.dart';

class MedicaRegisterCubit extends Cubit<MedicaRegisterStates> {
  MedicaRegisterCubit() : super(MedicaRegisterInitialState());

  static MedicaRegisterCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;
  bool passwordVisible = true;
  IconData suffix = Icons.visibility;

  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    suffix = passwordVisible ? Icons.visibility : Icons.visibility_off;
    emit(MedicaRegisterChangePasswordVisibilityState());
  }

  void userRegister({
    @required String? email,
    @required String? name,
    @required String? phone,
    @required String? password,
  }) {
    emit(MedicaRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        "name" : name,
        "phone" : phone,
        "email": email,
        "password": password
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(MedicaRegisterSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(MedicaRegisterFailureState(error.toString()));
    });
  }
}
