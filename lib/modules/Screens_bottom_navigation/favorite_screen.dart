import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone/models/Get_Fav_Model/get_fav_model.dart';
import 'package:medica_zone/shared/cubit/app_cubit.dart';
import 'package:medica_zone/shared/cubit/app_states.dart';
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    return   BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context,state){
        return ConditionalBuilder(
          condition: state  is!  AppLoadingGetFavDataState ,
          builder:(context)=> ListView.separated(
            itemBuilder:(context,index)=> buildFavItem(cubit.getFavModel!.data!.data![index],context),
            separatorBuilder: (context,index)=> Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),
            ),
            itemCount: cubit.getFavModel!.data!.data!.length,
          ),
          fallback:(context) => Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

  Widget buildFavItem(DataFav model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 150.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.product!.image!),
                width: 120,
                height: 120,
              ),
              if(model.product!.discount != 0)
                Container(
                  color: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'DISCOUND',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                    ) ,
                  ),
                ),
            ],
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.product!.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14,height: 1.3,),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                      model.product!.price.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          color:Colors.blue,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(width: 5,),
                    if(model.product!.oldPrice !=0)
                      Text(
                        model.product!.oldPrice.toString(),
                        style: TextStyle(fontSize: 13,
                          color:Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: AppCubit.get(context).favorite![model.product!.id]! ? Colors.blueAccent: Colors.grey ,
                      child: IconButton(
                        onPressed: (){
                          AppCubit.get(context).changeFavorites(model.product!.id!);
                        },
                        icon: Icon(
                          Icons.favorite_border,
                          size: 15.0,
                          color: Colors.white,),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),

                Center(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    height: 50 ,
                    color: Colors.blueAccent,
                    child: TextButton(
                        onPressed: (){},
                        child: Center(
                          child: Text("Add To Cart",
                            style: TextStyle(color: Colors.white,fontSize: 18),),
                        )
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
