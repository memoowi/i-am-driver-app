import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_am_driver/utils/theme.dart';

class CustomFormField extends StatelessWidget {
  final bool? obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? labelText;
  final VoidCallback? onTap;
  final bool readOnly;

  const CustomFormField({
    super.key,
    this.obscureText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      obscureText: obscureText ?? false,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        prefixIcon: Icon(prefixIcon),
        prefixIconColor: CustomColors.primaryColor,
        suffixIcon: suffixIcon,
        suffixIconColor: CustomColors.secondaryColor,
        isDense: true,
      ),
      style: CustomTextStyles.dark.copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
