import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone/shared/components/components.dart';
import 'package:medica_zone/shared/components/constants.dart';
import 'package:medica_zone/shared/cubit/app_cubit.dart';
import 'package:medica_zone/shared/cubit/app_states.dart';
class PersonScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameControler = TextEditingController();
  var PhoneControler = TextEditingController();
  var emailControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        if(state is AppSeccessGetUserDataState){

        }
      },
      builder: (context, state) {
        var model = AppCubit.get(context).userData;
        nameControler.text = model!.data!.name!;
        PhoneControler.text = model.data!.phone!;
        emailControler.text = model.data!.email!;
        return ConditionalBuilder(
          condition: AppCubit.get(context).userData != null,
          builder: (BuildContext context) {
            return  Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey ,
                child: Column(
                  children: [
                    if(state is AppLoadinUpdateDataState)
                    LinearProgressIndicator(),
                    SizedBox(height: 10,),
                    defaultFormField(
                        label_text: 'Name',
                        keyboard_type: TextInputType.name ,
                        controller_type: nameControler,
                        prefix_icon: Icons.person ,
                        Validate: (String? value){
                          if(value!.isEmpty){
                            return 'Name must not be Empty';
                          }
                          return null;
                        }
                    ),
                    SizedBox(height: 10,),

                    defaultFormField(
                        label_text: 'Email',
                        keyboard_type: TextInputType.emailAddress ,
                        controller_type: emailControler,
                        prefix_icon: Icons.email ,
                        Validate: (String? value){
                          if(value!.isEmpty){
                            return 'Email must not be Empty';
                          }
                          return null;
                        }
                    ),
                    SizedBox(height: 10,),
                    defaultFormField(
                        label_text: 'phone',
                        keyboard_type: TextInputType.phone ,
                        controller_type: PhoneControler,
                        prefix_icon: Icons.phone ,
                        Validate: (String? value){
                          if(value!.isEmpty){
                            return 'phone must not be Empty';
                          }
                          return null;
                        }
                    ),
                    SizedBox(height: 10,),
                    defaultButton(
                        function: () {
                          if(formKey.currentState!.validate()){
                            AppCubit.get(context).getUpdateData(
                                name: nameControler.text,
                                email: emailControler.text,
                                phone: PhoneControler.text
                            );
                          }

                        },
                        text: 'Update'),
                    SizedBox(height: 20,),
                    defaultButton(
                        function: () {
                          SignOut(context);
                        },
                        text: 'Log Out')

                  ],
                ),
              ),
            );
          },
          fallback: (context)=> Center(child: CircularProgressIndicator(),),
        );
      },

    );
  }
}
