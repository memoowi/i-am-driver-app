import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:i_am_driver/utils/theme.dart';

class CustomSnackBar {
  static void show(
      {required String message,
      required IconData icon,
      required BuildContext context}) {
    DelightToastBar(
      autoDismiss: true,
      position: DelightSnackbarPosition.top,
      animationDuration: const Duration(milliseconds: 300),
      builder: (context) {
        return ToastCard(
          leading: Icon(
            icon,
          ),
          title: Text(
            message,
            style: CustomTextStyles.darkMadimi,
          ),
          color: CustomColors.lightColor,
        );
      },
    ).show(context);
  }
}
