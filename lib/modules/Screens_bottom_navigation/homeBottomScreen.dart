import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone/models/categories_models/categories_models.dart';
import 'package:medica_zone/models/home_models/home_models.dart';
import 'package:medica_zone/shared/components/components.dart';
import 'package:medica_zone/shared/cubit/app_cubit.dart';
import 'package:medica_zone/shared/cubit/app_states.dart';
class HomeBottomScreen extends StatelessWidget {
  const HomeBottomScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   AppCubit cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return ConditionalBuilder(
            // ignore: unnecessary_null_comparison
            condition: cubit.homeModel != null && cubit.categoriesModel != null,
            builder: (context)=> ProductsBuilder(cubit.homeModel!,cubit.categoriesModel!,context),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
        );
      } ,
    );
  }

  Widget ProductsBuilder(HomeModel model,CategoriesModel categoriesmodel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: CarouselSlider(
            items: model.data!.banners.map(
                  (e) => Image(
                image: NetworkImage('${e.image}'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),).toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
        SizedBox(height: 10.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Category',style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.w800),),
              SizedBox(height: 7.0,),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildCategoryItem(categoriesmodel.data!.data[index]),
                  separatorBuilder: (BuildContext context, int index)=> SizedBox(
                    width: 10,
                  ),
                  itemCount: categoriesmodel.data!.data.length,
                ),
              ),
              SizedBox(height: 7.0,),
              Text('New Products',style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.w800),),
            ],
          ),
        ),
        SizedBox(height: 10.0,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2 ,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            childAspectRatio: 1/1.85 ,
            children: List.generate(model.data!.products.length,
                  (index) => buildGridview(model.data!.products[index],context),
            ),
          ),
        ),

      ],
    ),
  );
  Widget buildCategoryItem(DataCategoriesModels model)=> Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage("${model.image}"),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.8),
        width: 100,
        child: Text('${model.name}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,),),)
    ],
  );
  Widget buildGridview(ProductsHomeModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                  "${model.image}"
              ),
              width: double.infinity,
              height: 200.0,
            ),
            if(model.discount !=0)
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
        Padding(
          padding: const EdgeInsets.all(12.0),
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
                    "${model.price.round()}",
                    style: TextStyle(
                        fontSize: 15,
                        color:Colors.blue,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(width: 5,),
                  if(model.discount !=0)
                    Text(
                      "${model.old_price.round()}",
                      style: TextStyle(fontSize: 13,
                        color:Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
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
                          style: TextStyle(color: Colors.white,fontSize: 15),),
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
