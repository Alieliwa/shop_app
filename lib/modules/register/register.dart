import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medica_zone/shared/components/components.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var email = TextEditingController();

  var userName = TextEditingController();

  var password = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    keyboard_type: TextInputType.text,
                    controller_type: userName,
                    label_text: "userName",
                    Validate: (userNameCheck) {
                      if (userNameCheck!.isEmpty) {
                        return "userName mustn't be empty";
                      }
                      return null;
                    },
                    prefix_icon: Icons.person_outline_rounded,
                  ),
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
                    keyboard_type: TextInputType.visiblePassword,
                    controller_type: password,
                    label_text: "Password",
                    prefix_icon: Icons.lock,
                    suffix_icon: passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    isVisible: passwordVisible,
                    isPasswordVisible: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
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
                  defaultButton(
                    text: "register",
                    redius: 60.0,
                    function: () {
                      if (formKey.currentState!.validate()) {
                        // print(email.text);
                        // print(password.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
