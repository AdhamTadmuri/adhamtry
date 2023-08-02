import 'package:food_ordering_sp2/core/services/base_controller.dart';
import 'package:food_ordering_sp2/ui/shared/utils.dart';
import 'package:food_ordering_sp2/ui/views/main_view/main_view.dart';
import 'package:get/get.dart';

class CheckoutController extends BaseController {
  @override
  void onClose() {
    cartService.clearCart();
    Get.off(MainView());
    super.onClose();
  }
}
