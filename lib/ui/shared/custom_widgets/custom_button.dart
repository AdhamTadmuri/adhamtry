import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ordering_sp2/ui/shared/colors.dart';
import 'package:food_ordering_sp2/ui/shared/utils.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textFontWeight;
  final Color? borderColor;
  final Color? backgroundColor;
  final Function? onPressed;
  final String? imageName;
  final double? sizedbuttom;

  const CustomButton({
    Key? key,
    required this.text,
    this.textColor,
    this.textSize,
    this.textFontWeight,
    this.borderColor,
    this.backgroundColor,
    this.onPressed,
    this.imageName,
    this.sizedbuttom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) onPressed!();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageName != null) ...[
            SvgPicture.asset('assets/images/$imageName.svg'),
            SizedBox(
              width: size.width * 0.02,
            )
          ],
          Text(
            text,
            style: TextStyle(
                color: textColor ?? AppColors.mainWhiteColor,
                fontSize: textSize ?? size.width * 0.035,
                fontWeight: textFontWeight ?? FontWeight.normal),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
          side: borderColor != null
              ? BorderSide(
                  width: 1, color: borderColor ?? AppColors.mainOrangeColor)
              : null,
          backgroundColor: backgroundColor ?? AppColors.mainOrangeColor,
          shape: StadiumBorder(),
          fixedSize: Size(sizedbuttom ?? screenWidth(1.1), size.width * 0.14)),
    );
  }
}
