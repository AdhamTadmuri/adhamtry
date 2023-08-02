import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ordering_sp2/ui/shared/colors.dart';
import 'package:food_ordering_sp2/ui/shared/utils.dart';
import 'package:food_ordering_sp2/ui/views/splash_screen/splash_screen_controller.dart';
import 'package:get/get.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  SplashScreenController controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Stack(
      fit: StackFit.expand,
      children: [
        SvgPicture.asset(
          'assets/images/bg_background.svg',
          width: screenWidth(1),
          height: screenHeight(1),
        ),
        Center(
          child: SvgPicture.asset(
            'assets/images/Logo.svg',
            width: screenWidth(2),
            height: screenWidth(2),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: screenHeight(1.5)),
          child: SpinKitThreeBounce(
            color: AppColors.mainOrangeColor,
          ),
        )
      ],
    )));
  }
}
