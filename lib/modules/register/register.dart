import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone/modules/home/home_screen.dart';
import 'package:medica_zone/shared/components/components.dart';
import 'package:medica_zone/shared/components/constants.dart';
import 'package:medica_zone/shared/network/local/cache_helper.dart';

import 'cubitreg/register_state.dart';
import 'cubitreg/registercubit.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var email = TextEditingController();

  var phone = TextEditingController();

  var name = TextEditingController();

  var password = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool passwordVisible = true;

  @override
  Widget build(BuildContext context)
  {

    return BlocProvider(
      create: (BuildContext context) => MedicaRegisterCubit(),
      child: BlocConsumer<MedicaRegisterCubit,MedicaRegisterStates>(
        listener: (context, state) {
          if (state is MedicaRegisterSuccessState) {
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
          var cubit = MedicaRegisterCubit.get(context);
          return  Scaffold(
            appBar: AppBar(),
            body:  Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        defaultFormField(
                            keyboard_type: TextInputType.name,
                            controller_type: name,
                            label_text: "User Name",
                            prefix_icon: Icons.person,
                            Validate: (nameCheck) {
                              if (nameCheck!.isEmpty) {
                                return "UserName mustn't be empty";
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
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
                            keyboard_type: TextInputType.phone,
                            controller_type: phone,
                            label_text: "Phone",
                            prefix_icon: Icons.phone,
                            Validate: (phoneCheck) {
                              if (phoneCheck!.isEmpty) {
                                return "Phone mustn't be empty";
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
                            // if (formKey.currentState!.validate()) {
                            //   cubit.userRegister
                            //     (
                            //       email: email.text,
                            //       password: password.text,
                            //       name: name.text,
                            //       phone: phone.text
                            //   );
                            // }
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
                          // ignore: unnecessary_type_check
                          condition: state is! MedicaRegisterLoadingState,
                          builder: (context) => defaultButton(
                            text: "Regester",
                            redius: 60.0,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  email: email.text,
                                  password: password.text,
                                  name: name.text,
                                  phone: phone.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
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