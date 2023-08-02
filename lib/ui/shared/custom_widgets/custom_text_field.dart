import 'package:flutter/material.dart';
import 'package:food_ordering_sp2/ui/shared/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hitText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.hitText,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: size.width * 0.1,
          end: size.width * 0.1,
          bottom: size.width * 0.07),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1, vertical: size.width * 0.05),
            hintText: hitText,
            filled: true,
            fillColor: AppColors.mainGreyColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none)),
        //  validator: (value) => validator != null ? validator!(value!) : null,
      ),
    );
  }
}
