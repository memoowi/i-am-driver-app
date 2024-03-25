import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_driver/bloc/auth_bloc.dart';
import 'package:i_am_driver/utils/theme.dart';
import 'package:i_am_driver/widgets/custom_filled_button.dart';
import 'package:i_am_driver/widgets/custom_outline_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    void logout() {
      context.read<AuthBloc>().add(Signout(context: context));
    }

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnauthenticatedState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        final user = state is AuthenticatedState ? state.user : null;
        return Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            CustomColors.primaryColor,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100)),
                      ),
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
                const CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: CustomColors.lightColor,
                    foregroundImage: AssetImage('assets/profile-3.png'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SafeArea(
                child: Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                    color: CustomColors.lightColor,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.darkColor.withOpacity(0.2),
                        blurRadius: 20.0,
                        offset: const Offset(0, 10.0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        user?.name ?? 'Loading...',
                        style: CustomTextStyles.secondaryMadimi.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '(${user?.phoneNumber})',
                        style: CustomTextStyles.grey.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        user?.email ?? 'Loading...',
                        style: CustomTextStyles.dark.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const Spacer(),
                      CustomOutlineButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              title: const Text(
                                  'Are you sure you want to logout?'),
                              titleTextStyle:
                                  CustomTextStyles.darkMadimi.copyWith(
                                fontSize: 20,
                              ),
                              actions: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomOutlineButton(
                                        text: 'Cancel',
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomFilledButton(
                                        text: 'Yes',
                                        onPressed: (state is AuthLoadingState)
                                            ? null
                                            : logout,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        text: 'Logout',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
