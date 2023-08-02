import 'package:food_ordering_sp2/core/data/models/cart_model.dart';
import 'package:food_ordering_sp2/core/services/base_controller.dart';
import 'package:food_ordering_sp2/ui/shared/utils.dart';
import 'package:food_ordering_sp2/ui/views/checkout_view/checkout_view.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class CartController extends BaseController {
  List<CartModel> get cartList => cartService.cartList;

  @override
  void onInit() {
    super.onInit();
  }

  void removeFromCart(CartModel model) {
    cartService.removeFromCart(
      model: model,
    );
  }

  void changeCount(bool incress, CartModel model) {
    cartService.changeCount(
      incress: incress,
      model: model,
    );
  }

  void checkout() {
    runFullLoadingFunction(
        function: Future.delayed(Duration(seconds: 2)).then((value) {
      Get.off(CheckoutView());
    }));
  }
}
