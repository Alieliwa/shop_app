import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone/modules/login/login.dart';
import 'package:medica_zone/shared/components/components.dart';
import 'package:medica_zone/shared/cubit/app_cubit.dart';
import 'package:medica_zone/shared/cubit/app_states.dart';
import 'package:medica_zone/shared/network/local/cache_helper.dart';
import '../search_Screen/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AppCubit Cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit,AppStates>(
     listener: (context, state){},
      builder: (context,state){
       return  Scaffold(
         appBar: AppBar(
           actions: [
             IconButton(
               onPressed: () {
                 Cubit.changeMode();
               },
               icon:
               !Cubit.isDark ? Icon(Icons.brightness_4_outlined):Icon(Icons.wb_sunny_rounded),
             ),
             IconButton(
                 onPressed: () {
                   navigateTo(context, SearchScreen());
                 },
                 icon: Icon(
                   Icons.search,
                   size: 30,
                 )),
           ],
           title: Text(Cubit.titles[Cubit.currentIndex]),
         ),
         body: Cubit.Screens[Cubit.currentIndex],
         bottomNavigationBar: BottomNavigationBar(
           currentIndex: Cubit.currentIndex,
           onTap: (index) {
             setState(() {
               Cubit.ChangeIndx(index);
             });
           },
           items: Cubit.bottomitems,
         ),
       );
      },

    );
  }

}
/*
// drawer: Drawer(
//   child: ListView(
//     children: [
//       DrawerHeader(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               backgroundColor: Colors.grey,
//               maxRadius: 40,
//             ),
//             Text('User Name'),
//             Spacer(),
//             IconButton(
//                 onPressed: (){
//                   Cubit.changeMode();
//                 },
//                 icon: !Cubit.isDark ? Icon(Icons.brightness_4_outlined):Icon(Icons.wb_sunny_rounded), ),
//
//           ],
//         ),
//         decoration: BoxDecoration(
//           color: Colors.white,
//         ),
//
//       ),
//       Padding(
//         padding: const EdgeInsets.only(left: 10),
//         child: Text(
//           'Help & Info',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//       ),
//       ListTile(
//           leading: Icon(Icons.unarchive_sharp),
//         title: Text('About Us',
//           style: TextStyle(fontSize: 15,
//               fontWeight: FontWeight.normal),),
//       ),
//       ListTile(
//           leading: Icon(Icons.headset_mic_outlined),
//         title: Text('Contact Us',
//           style: TextStyle(fontSize: 15,
//               fontWeight: FontWeight.normal),),
//       ),
//       ListTile(
//           leading: Icon(Icons.contact_support_outlined),
//         title: Text('FAQ',
//           style: TextStyle(fontSize: 15,
//               fontWeight: FontWeight.normal),),
//       ),
//     ],
//   ),
// ),
 */
