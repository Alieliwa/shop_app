import 'package:medica_zone/models/login/login_model.dart';

abstract class MedicaRegisterStates {}

class MedicaRegisterInitialState extends MedicaRegisterStates {}

class MedicaRegisterLoadingState extends MedicaRegisterStates {}

class MedicaRegisterSuccessState extends MedicaRegisterStates {
  LoginModel loginModel;

  MedicaRegisterSuccessState(this.loginModel);
}

class MedicaRegisterFailureState extends MedicaRegisterStates {
  final String error;

  MedicaRegisterFailureState(this.error);
}

class MedicaRegisterChangePasswordVisibilityState extends MedicaRegisterStates {}
