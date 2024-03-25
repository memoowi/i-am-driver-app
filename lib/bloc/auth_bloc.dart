import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:i_am_driver/models/user_model.dart';
import 'package:i_am_driver/utils/config.dart';
import 'package:i_am_driver/utils/custim_snack_bar.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final dio = Dio();
  AuthBloc() : super(AuthInitialState()) {
    on<AppStarted>((event, emit) async {
      emit(AuthLoadingState());
      String? token = await getToken();
      if (token != null) {
        try {
          final user = await getUser(token);
          if (user != null) {
            if (user.role == 'driver') {
              emit(AuthenticatedState(user: user));
            } else {
              deleteToken();
              emit(UnauthenticatedState());
            }
          } else {
            deleteToken();
            emit(UnauthenticatedState());
          }
        } on DioException catch (e) {
          log(e.toString());
          deleteToken();
          emit(UnauthenticatedState());
        }
      } else {
        emit(UnauthenticatedState());
      }
    });

    on<Signin>((event, emit) async {
      emit(AuthLoadingState());

      try {
        final response = await dio.post(
          Config.loginUrl,
          data: {
            'username': event.username,
            'password': event.password,
          },
        );

        if (response.statusCode == 200) {
          String token = response.data['token'];
          final user = await getUser(token);
          if (user!.role == 'driver') {
            await saveToken(token);
            if (event.context.mounted) {
              CustomSnackBar.show(
                  message: 'Login Successful',
                  icon: Icons.check,
                  context: event.context);
            }
            emit(AuthenticatedState(user: user));
          } else {
            emit(UnauthenticatedState());
            if (event.context.mounted) {
              CustomSnackBar.show(
                message: 'Please login with driver account',
                icon: Icons.error,
                context: event.context,
              );
            }
          }
        } else {
          emit(UnauthenticatedState());
        }
      } on DioException catch (e) {
        if (e.response?.statusCode == 401 || e.response?.statusCode == 404) {
          String message = e.response?.data['message'];
          if (event.context.mounted) {
            CustomSnackBar.show(
                message: message, icon: Icons.error, context: event.context);
          }
        }
        emit(UnauthenticatedState());
      }
    });

    on<Signup>((event, emit) async {
      emit(AuthLoadingState());

      try {
        final response = await dio.post(
          Config.registerUrl,
          data: {
            'name': event.name,
            'phone_number': event.phoneNumber,
            'email': event.email,
            'password': event.password,
            'role': 'driver',
          },
        );

        if (response.statusCode == 201) {
          String token = response.data['token'];
          await saveToken(token);
          final user = await getUser(token);
          if (event.context.mounted) {
            CustomSnackBar.show(
              message: 'Registration Successful',
              icon: Icons.check,
              context: event.context,
            );
          }
          emit(AuthenticatedState(user: user!));
        } else {
          emit(UnauthenticatedState());
        }
      } on DioException catch (e) {
        if (e.response?.statusCode == 400) {
          Map<String, dynamic> message = e.response?.data['errors'];
          if (event.context.mounted) {
            message.forEach(
              (key, value) {
                CustomSnackBar.show(
                  message: value[0],
                  icon: Icons.error,
                  context: event.context,
                );
              },
            );
          }
        }
        emit(UnauthenticatedState());
      }
    });

    on<Signout>((event, emit) async {
      emit(AuthLoadingState());

      try {
        final token = await getToken();
        final response = await dio.post(
          Config.logoutUrl,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }),
        );
        if (response.statusCode == 200) {
          if (event.context.mounted) {
            CustomSnackBar.show(
                message: 'Logout Successful',
                icon: Icons.check,
                context: event.context);
          }
        }
      } on DioException catch (e) {
        log(e.toString());
        if (event.context.mounted) {
          CustomSnackBar.show(
              message: 'An error occured',
              icon: Icons.error,
              context: event.context);
        }
      } finally {
        await deleteToken();
        emit(UnauthenticatedState());
      }
    });
  }

  Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }

  Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
  }

  Future<void> deleteToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('token');
  }

  Future<UserModel?> getUser(String token) async {
    try {
      final response = await dio.get(Config.userUrl,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      log(e.toString());
      return null;
    }
  }
}
