import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ordering_sp2/app/my_app.dart';
import 'package:food_ordering_sp2/core/enums/message_type.dart';
import 'package:food_ordering_sp2/ui/shared/colors.dart';
import 'package:food_ordering_sp2/ui/shared/utils.dart';

class CustomToast {
  static showMeassge({
    required String message,
    MessageType messageType = MessageType.INFO,
  }) {
    String imageName = 'info';
    Color shadowColor = AppColors.mainBlueColor;

    switch (messageType) {
      case MessageType.INFO:
        imageName = 'info';
        shadowColor = AppColors.mainBlueColor;
        break;
      case MessageType.WARNING:
        imageName = 'warning';
        shadowColor = AppColors.mainOrangeColor;
        break;
      case MessageType.REJECTED:
        imageName = 'rejected-01';
        shadowColor = AppColors.mainRedColor;
        break;
      case MessageType.SUCCSESS:
        imageName = 'approved1-01';
        shadowColor = AppColors.mainGreyColor;
        break;
    }

    BotToast.showCustomText(
        duration: Duration(seconds: 5),
        toastBuilder: (value) {
          return Container(
            width: screenWidth(5),
            height: screenWidth(5),
            decoration: BoxDecoration(
                color: AppColors.mainWhiteColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(
                'assets/images/$imageName.svg',
                width: screenWidth(5),
                height: screenWidth(5),
              ),
              SizedBox(
                height: screenWidth(5),
              ),
              Text(
                message,
                style: TextStyle(
                  fontSize: screenWidth(5),
                ),
              )
            ]),
          );
        });
  }
}
