import 'package:flutter/material.dart';
import 'package:i_am_driver/utils/theme.dart';

class AuthBrandBanner extends StatelessWidget {
  final bool isLoginScreen;
  const AuthBrandBanner({
    super.key,
    this.isLoginScreen = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: isLoginScreen ? TextDirection.ltr : TextDirection.rtl,
      children: [
        Image.asset(
          'assets/logo-2.png',
          scale: 0.8,
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: isLoginScreen
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: isLoginScreen
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'I-Am',
                    style: CustomTextStyles.secondaryMadimi.copyWith(
                      fontSize: 36.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Driver',
                    style: CustomTextStyles.greenMadimi.copyWith(
                      fontSize: 24.0,
                    ),
                  ),
                ],
              ),
              Text(
                isLoginScreen
                    ? 'Your Free Lifeline in Emergencies.'
                    : 'Free Help.\nFast Response.',
                style: CustomTextStyles.dark.copyWith(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: isLoginScreen ? TextAlign.start : TextAlign.end,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
