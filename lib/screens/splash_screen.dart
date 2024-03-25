import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_driver/bloc/auth_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            Future.delayed(const Duration(seconds: 2), () {
              return Navigator.of(context).pushReplacementNamed(
                '/home',
              );
            });
          } else if (state is UnauthenticatedState) {
            Future.delayed(const Duration(seconds: 2), () {
              return Navigator.of(context).pushReplacementNamed(
                '/login',
              );
            });
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/logo-2.png',
                scale: 0.7,
                filterQuality: FilterQuality.high,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: const LinearProgressIndicator(
                minHeight: 5.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
