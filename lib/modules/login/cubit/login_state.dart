import 'package:medica_zone/models/login/login_model.dart';

abstract class MedicaLoginStates {}

class MedicaLoginInitialState extends MedicaLoginStates {}

class MedicaLoginLoadingState extends MedicaLoginStates {}

class MedicaLoginSuccessState extends MedicaLoginStates {
  LoginModel loginModel;

  MedicaLoginSuccessState(this.loginModel);
}

class MedicaLoginFailureState extends MedicaLoginStates {
  final String error;

  MedicaLoginFailureState(this.error);
}

class MedicaLoginChangePasswordVisibilityState extends MedicaLoginStates {}
