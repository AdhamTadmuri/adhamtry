import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_sp2/core/data/repositories/shared_prefreance_repository.dart';
import 'package:food_ordering_sp2/core/data/repositories/user_repository.dart';
import 'package:food_ordering_sp2/core/enums/message_type.dart';
import 'package:food_ordering_sp2/core/services/base_controller.dart';
import 'package:food_ordering_sp2/ui/shared/custom_widgets/custom_toast.dart';
import 'package:food_ordering_sp2/ui/shared/utils.dart';
import 'package:food_ordering_sp2/ui/views/main_view/main_view.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  TextEditingController emailController =
      TextEditingController(text: 'Test@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: 'Test@1234');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void login() {
    if (formKey.currentState!.validate()) {
      runFullLoadingFunction(
          function: UserRepository()
              .login(
                  email: emailController.text,
                  password: passwordController.text)
              .then((value) {
        value.fold((l) {
          CustomToast.showMeassge(
              message: l, messageType: MessageType.REJECTED);
        }, (r) {
          storage.setLoggedIN(true);
          storage.setTokenInfo(r);
          Get.off(MainView(), transition: Transition.cupertino);
        });
      }));
    }
  }
}

void cupertinoTransition(Widget view) {
  Get.off(view, transition: Transition.cupertino);
}
