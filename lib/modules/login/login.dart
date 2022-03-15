import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medica_zone/modules/home/home_screen.dart';
import 'package:medica_zone/modules/login/cubit/login_cubit.dart';
import 'package:medica_zone/modules/login/cubit/login_state.dart';
import 'package:medica_zone/modules/register/register.dart';
import 'package:medica_zone/shared/components/components.dart';
import 'package:medica_zone/shared/components/constants.dart';
import 'package:medica_zone/shared/network/local/cache_helper.dart';

class Login extends StatelessWidget {
  var email = TextEditingController();

  var password = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MedicaLoginCubit(),
      child: BlocConsumer<MedicaLoginCubit, MedicaLoginStates>(
        listener: (context, state) {
          if (state is MedicaLoginSuccessState) {
            if (state.loginModel.status == true) {
              CacheHelper.saveData(
                      key: 'token',
                  value: state.loginModel.data!.token)
                  .then((value) {
                    token = state.loginModel.data!.token!;
                navigateAndFinish(context, HomeScreen());
              });

            } else {
              showToast(
                  state: ToastStates.ERROR,
                  text: "${state.loginModel.message}",);
            }
          } else {}
        },
        builder: (context, state) {
          var cubit = MedicaLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'LOGIN',
                style: TextStyle(fontSize: 30),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        defaultFormField(
                            keyboard_type: TextInputType.emailAddress,
                            controller_type: email,
                            label_text: "Email",
                            prefix_icon: Icons.email,
                            Validate: (emailCheck) {
                              if (emailCheck!.isEmpty) {
                                return "Email mustn't be empty";
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          keyboard_type: TextInputType.visiblePassword,
                          controller_type: password,
                          label_text: "Password",
                          prefix_icon: Icons.lock,
                          suffix_icon: cubit.suffix,
                          isVisible: cubit.passwordVisible,
                          isPasswordVisible: () {
                            cubit.changePasswordVisibility();
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                  email: email.text, password: password.text);
                            }
                          },
                          Validate: (passwordCheck) {
                            if (passwordCheck!.isEmpty) {
                              return "Password mustn't be empty";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! MedicaLoginLoadingState,
                          builder: (context) => defaultButton(
                            text: "login",
                            redius: 60.0,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  email: email.text,
                                  password: password.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have account?",
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, Register());
                              },
                              child: Text("Register Here"),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
