import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone/models/SearchModel/search_model.dart';
import 'package:medica_zone/modules/search_Screen/cubit/search_cubit.dart';
import 'package:medica_zone/modules/search_Screen/cubit/search_states.dart';
import 'package:medica_zone/shared/components/components.dart';
import 'package:medica_zone/shared/cubit/app_cubit.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var SearchControler = TextEditingController();
    return BlocProvider(
      create: (context)=> SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Center(child: Text('Search')),
            ),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: defaultFormField(
                        label_text: 'Search',
                        keyboard_type: TextInputType.text ,
                        controller_type: SearchControler,
                        prefix_icon: Icons.search ,
                        onSubmit: (String ? text){
                          SearchCubit.get(context).Search(text!);
                        },
                        Validate: (String? value){
                          if(value!.isEmpty){
                            return 'Name must not be Empty';
                          }
                          return null;
                        }
                    ),
                  ),
                  SizedBox(height: 20,),
                  if(state is SearchLoadingStates)
                  CircularProgressIndicator(),
                  SizedBox(height: 10,),
                  if(state is SearchSeccuessStates)
                  Expanded(
                    child: ListView.separated(
                      itemBuilder:(context,index)=> buildFavItem(SearchCubit.get(context).searchModel!.allData!.data![index],context),
                      separatorBuilder: (context,index)=> Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          width: double.infinity,
                          height: 1.0,
                          color: Colors.grey,
                        ),
                      ),
                      itemCount: SearchCubit.get(context).searchModel!.allData!.data!.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        },

      ),
    );

  }
  Widget buildFavItem(Data model,context,)=>Padding(
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
                image: NetworkImage(model.image!),
                width: 120,
                height: 120,
              ),

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
                  "${model.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14,height: 1.3,),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          color:Colors.blue,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(width: 5,),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: AppCubit.get(context).favorite![model.id]! ? Colors.blueAccent: Colors.grey ,
                      child: IconButton(
                        onPressed: (){
                          AppCubit.get(context).changeFavorites(model.id!);
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
