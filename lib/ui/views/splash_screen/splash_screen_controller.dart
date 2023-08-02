import 'package:food_ordering_sp2/core/data/repositories/shared_prefreance_repository.dart';
import 'package:food_ordering_sp2/core/enums/message_type.dart';
import 'package:food_ordering_sp2/ui/shared/custom_widgets/custom_toast.dart';
import 'package:food_ordering_sp2/ui/shared/utils.dart';
import 'package:food_ordering_sp2/ui/views/intro_view/intro_view.dart';
import 'package:food_ordering_sp2/ui/views/landing_view/landing_view.dart';
import 'package:food_ordering_sp2/ui/views/main_view/main_view.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    if (storage.getOrderPlaced()) {
      cartService.clearCart();
      storage.setOrderPlaced(false);
    }
    Future.delayed(Duration(seconds: 5)).then((value) {
      // if (storage.getFirstLunch()) {
      //   Get.off(IntroView());
      // } else {
      //   Get.off(storage.getLoggedIN() ? LandingView() : LandingView());
      // }
      // //Get.back();
      // storage.setFirstLunch(false);

      if (storage.getSubStatus()) {
        Get.off(LandingView());
      } else {
        CustomToast.showMeassge(
            message: 'Your sub expired', messageType: MessageType.WARNING);
      }
    });
    super.onInit();
  }
}
