import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ordering_sp2/ui/shared/colors.dart';
import 'package:food_ordering_sp2/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_ordering_sp2/ui/shared/utils.dart';
import 'package:food_ordering_sp2/ui/views/landing_view/landing_controller.dart';
import 'package:food_ordering_sp2/ui/views/login_view/login_view.dart';
import 'package:food_ordering_sp2/ui/views/map_view/map_view.dart';
import 'package:food_ordering_sp2/ui/views/singup_view/new_2_singup_view.dart';
import 'package:food_ordering_sp2/ui/views/singup_view/new_singup_view.dart';
import 'package:food_ordering_sp2/ui/views/singup_view/singup_view.dart';

import 'package:food_ordering_sp2/ui/views/splash_screen/splash_screen_view.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';
import 'package:location/location.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  LandingController controller = Get.put(LandingController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        Stack(
          children: [
            CustomPaint(
              painter: ClipShadowShadowPainter(
                clipper: LandingClipper(),
                shadow: Shadow(blurRadius: 12),
              ),
              child: ClipPath(
                clipper: LandingClipper(),
                child: Container(
                  width: size.width,
                  height: size.height * 0.45,
                  alignment: Alignment.bottomCenter,
                  child: SvgPicture.asset(
                    'assets/images/Background objects.svg',
                    fit: BoxFit.fitWidth,
                    width: size.width,
                  ),
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(252, 96, 17, 1)),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.35),
                child: SvgPicture.asset(
                  'assets/images/Logo.svg',
                  width: size.width * 0.4,
                  height: size.width * 0.4,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.width * 0.15),
          child: Text(
            'Discover the best foods from over 1,000 \n restaurants and fast delivery to your doorstep',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: size.width * 0.04),
          ),
        ),
        Column(children: [
          Obx(() {
            return CustomButton(
                text: 'Login',
                backgroundColor: controller.color.value,
                onPressed: () async {
                  LocationData? currentLocation =
                      await locationService.getCurrentLocation();

                  if (currentLocation != null)
                    Get.to(MapView(
                      currentLocation: currentLocation,
                    ));
                });
          }),
          SizedBox(
            height: size.width * 0.05,
          ),
          CustomButton(
              text: 'Create an Account',
              textColor: AppColors.mainOrangeColor,
              borderColor: AppColors.mainOrangeColor,
              backgroundColor: AppColors.mainWhiteColor,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Singup2View();
                  },
                ));
              }),
        ]),
      ],
    )));
  }
}

class LandingClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(size.width * 0.0008333, size.height * 0.0014286);
    path0.lineTo(size.width, 0);
    path0.quadraticBezierTo(size.width, size.height * 0.6964286, size.width,
        size.height * 0.9285714);
    path0.quadraticBezierTo(size.width * 0.9968083, size.height * 1.0063571,
        size.width * 0.9591667, size.height);
    path0.lineTo(size.width * 0.6664500, size.height);
    path0.quadraticBezierTo(size.width * 0.6596000, size.height * 0.7251000,
        size.width * 0.5001750, size.height * 0.7281714);
    path0.quadraticBezierTo(size.width * 0.3309417, size.height * 0.7312429,
        size.width * 0.3327583, size.height);
    path0.lineTo(size.width * 0.0460500, size.height);
    path0.quadraticBezierTo(size.width * 0.0006667, size.height * 1.0078714, 0,
        size.height * 0.9271429);
    path0.quadraticBezierTo(size.width * 0.0002083, size.height * 0.6957143,
        size.width * 0.0008333, size.height * 0.0014286);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
