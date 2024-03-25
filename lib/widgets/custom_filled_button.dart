import 'package:flutter/material.dart';
import 'package:i_am_driver/utils/theme.dart';

class CustomFilledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const CustomFilledButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.secondaryColor,
        foregroundColor: CustomColors.lightColor,
        disabledBackgroundColor: CustomColors.secondaryColor.withOpacity(0.5),
        disabledForegroundColor: CustomColors.lightColor.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minimumSize: const Size.fromHeight(48.0),
        elevation: 0.0,
      ),
      child: Text(
        text,
        style: CustomTextStyles.light.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
