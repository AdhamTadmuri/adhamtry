import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ordering_sp2/ui/shared/colors.dart';
import 'package:food_ordering_sp2/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_ordering_sp2/ui/views/landing_view/landing_view.dart';

class IntroView extends StatefulWidget {
  IntroView({Key? key}) : super(key: key);

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  List<String> titleList = [
    'Find Food You Love',
    'Fast Delivery',
    'Live Tracking'
  ];

  List<String> descriptionList = [
    'Discover the best foods from over 1,000 \n restaurants and fast delivery to your doorstep',
    'Fast food delivery to your home, office \n wherever you are',
    'Real time tracking of your food on the app \n once you placed the order'
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.width * 0.07),
        child: Column(children: [
          SvgPicture.asset('assets/images/intro$currentIndex.svg'),
          Padding(
            padding: EdgeInsets.only(
                top: size.width * 0.05, bottom: size.width * 0.1),
            child: DotsIndicator(
              dotsCount: 3,
              position: currentIndex.toDouble(),
              decorator: DotsDecorator(
                color: AppColors.mainTextColor,
                activeColor: AppColors.mainOrangeColor,
              ),
            ),
          ),
          Text(
            titleList[currentIndex],
            style: TextStyle(
                color: AppColors.mainBlackColor,
                fontSize: size.width * 0.07,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.width * 0.05, bottom: size.width * 0.1),
            child: Text(descriptionList[currentIndex],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.mainBlackColor,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.normal)),
          ),
          Spacer(),
          CustomButton(
            text: currentIndex != 2 ? 'Next' : 'Finish',
            onPressed: () {
              if (currentIndex != 2)
                setState(() {
                  currentIndex = currentIndex + 1;
                });
              else
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return LandingView();
                  },
                ));
            },
          )
        ]),
      ),
    ));
  }
}
