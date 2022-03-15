import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone/models/categories_models/categories_models.dart';
import 'package:medica_zone/shared/cubit/app_cubit.dart';
import 'package:medica_zone/shared/cubit/app_states.dart';


class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    AppCubit cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context,state){
        return  ListView.separated(
            itemBuilder:(context,index)=> BuildCatItem(cubit.categoriesModel!.data!.data[index]),
            separatorBuilder: (context,index)=> Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),
            ),
            itemCount: cubit.categoriesModel!.data!.data.length,
        );
      },
    );

  }
Widget BuildCatItem(DataCategoriesModels model) => Padding(
  padding: const EdgeInsets.all(20),
  child: Row(
    children: [
      Image(
        image: NetworkImage("${model.image}"),
        width: 80,
        height: 80,
      ),
      Text(
        '${model.name}',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      ),
      Spacer(),
      Icon(
        Icons.arrow_forward_ios,
      )

    ],
  ),
);

}