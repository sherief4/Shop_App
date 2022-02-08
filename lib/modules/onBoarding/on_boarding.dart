import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/boarding_model.dart';
import 'package:shop_app/modules/shop_login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/common_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel('assets/images/1.jpg', 'Screen Title 1', 'Content 1 '),
    BoardingModel('assets/images/2.jpg', 'Screen Title 2', 'Content 2 '),
    BoardingModel('assets/images/3.jpg', 'Screen Title 3', 'Content 3 '),
  ];

  var boardController = PageController();

  bool isLast = false;
  
  void submit(){
    CacheHelper.putData(value: true, key: 'OnBoarding').then((value){
      if(value){
        print(CacheHelper.getData('OnBoarding'));
        navigateAndFinish(context, ShopLoginScreen());

      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
            child: const Text(
              'Skip',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.deepPurple,
              ),
            ),
            onPressed: () {
              submit();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemCount: boarding.length,
                controller: boardController,
                physics: const BouncingScrollPhysics(),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const WormEffect(
                      dotColor: Colors.grey, activeDotColor: Colors.deepPurple),
                ),
                const Spacer(),
                FloatingActionButton(
                  child: const Icon(Icons.navigate_next),
                  onPressed: () {
                    isLast != false
                        ? submit()
                        : boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 800,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          model.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          model.content,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
