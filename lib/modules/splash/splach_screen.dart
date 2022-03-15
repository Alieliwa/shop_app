import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medica_zone/models/onboarding/onboarding.dart';
import 'package:medica_zone/modules/home/home_screen.dart';
import 'package:medica_zone/modules/login/login.dart';
import 'package:medica_zone/shared/components/components.dart';
import 'package:medica_zone/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<OnBoadringModel> list = [
      OnBoadringModel(
          image:
              "https://img.freepik.com/free-photo/doctor-s-hand-with-stethoscope-medical-equipment-s-white-background_23-2148129660.jpg?size=626&ext=jpg",
          title: "Title1",
          body: "Body1"
      ),
      OnBoadringModel(
          image:
              "https://img.freepik.com/free-photo/doctor-s-hand-with-stethoscope-medical-equipment-s-white-background_23-2148129660.jpg?size=626&ext=jpg",
          title: "Title2",
          body: "Body2"),
      OnBoadringModel(
          image:
              "https://img.freepik.com/free-photo/doctor-s-hand-with-stethoscope-medical-equipment-s-white-background_23-2148129660.jpg?size=626&ext=jpg",
          title: "Title3",
          body: "Body3"),
      OnBoadringModel(
          image:
              "https://img.freepik.com/free-photo/doctor-s-hand-with-stethoscope-medical-equipment-s-white-background_23-2148129660.jpg?size=626&ext=jpg",
          title: "Title4",
          body: "Body4"),
    ];
    var boardController = PageController();
    bool isLast = false;

    void submit(){
      CacheHelper.saveData(key: 'onBoarding' , value: true).then((value){
        if(value){
          navigateAndFinish(
            context,
            HomeScreen(),
          );
        }
      });

    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Medica Zone",),
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text(
                "Skip Intro",
                style:
                    TextStyle(fontWeight: FontWeight.bold),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == list.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) => buildBoardingItem(list[index]),
                itemCount: list.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: list.length,
                  axisDirection: Axis.horizontal,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 10.0,
                    strokeWidth: 10.0,
                    activeDotColor: Colors.blue,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  mini: true,
                  child: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(OnBoadringModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Image(image: NetworkImage("${model.image}"))),
          Text(
            "${model.title}",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "${model.body}",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      );
}
