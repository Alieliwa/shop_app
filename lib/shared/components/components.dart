import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medica_zone/models/home_models/home_models.dart';

Widget defaultButton(
        {double width = double.infinity,
        Color background = Colors.blue,
        double redius = 20.0,
        bool isUpper = true,
        @required VoidCallback? function,
        @required String? text}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(redius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpper ? text!.toUpperCase() : text!,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  @required TextInputType? keyboard_type,
  @required TextEditingController? controller_type,
  @required String? label_text,
  IconData? prefix_icon,
  IconData? suffix_icon,
  Function(String)? onChange,
  Function(String)? onSubmit,
  @required String? Function(String?)? Validate,
  VoidCallback? isPasswordVisible,
  bool isVisible = false,
}) =>
    TextFormField(
      keyboardType: keyboard_type,
      controller: controller_type,
      obscureText: isVisible,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      validator: Validate,
      decoration: InputDecoration(
        labelText: label_text,
        prefixIcon: Icon(prefix_icon),
        suffixIcon: suffix_icon != null
            ? IconButton(onPressed: isPasswordVisible, icon: Icon(suffix_icon))
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false);

void showToast({
  required String? text,
  required ToastStates state,
})=> Fluttertoast.showToast(
    msg: text!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: ChoseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0);

enum ToastStates{
  SUCCESS, ERROR, WARNING
}
Color ChoseToastColor(ToastStates state) {
  Color color;
  switch (state){
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color=  Colors.red;
      break;
    case ToastStates.WARNING:
      color=  Colors.amber;
  }
  return color;
}