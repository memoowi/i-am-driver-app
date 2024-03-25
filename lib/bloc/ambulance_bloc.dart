import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_am_driver/utils/config.dart';
import 'package:i_am_driver/utils/custim_snack_bar.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'ambulance_event.dart';
part 'ambulance_state.dart';

class AmbulanceBloc extends Bloc<AmbulanceEvent, AmbulanceState> {
  final dio = Dio();
  AmbulanceBloc() : super(AmbulanceInitial()) {
    on<EditAmbulanceEvent>((event, emit) {
      emit(AmbulanceEditState());
    });

    on<CancelEditAmbulanceEvent>((event, emit) {
      emit(AmbulanceInitial());
    });

    on<UpdateBasicAmbulanceEvent>((event, emit) async {
      final token = await getToken();

      try {
        final response = await dio.patch(Config.ambulanceUrl,
            data: {
              'model': event.model,
              'license_plate': event.licensePlate,
            },
            options: Options(headers: {
              'Authorization': 'Bearer $token',
            }));

        if (response.statusCode == 200) {
          if (event.context.mounted) {
            CustomSnackBar.show(
                message: response.data['message'],
                icon: Icons.done,
                context: event.context);
          }
          emit(AmbulanceSuccessState());
        }
      } on DioException catch (e) {
        log(e.toString());
        if (event.context.mounted) {
          CustomSnackBar.show(
              message: e.response!.data['message'],
              icon: Icons.error,
              context: event.context);
        }
        emit(AmbulanceEditState());
      } finally {
        emit(AmbulanceInitial());
      }
    });
    on<UpdateLocationAmbulanceEvent>((event, emit) async {
      final token = await getToken();

      try {
        final response = await dio.patch(Config.ambulanceUrl,
            data: {
              'latitude': event.latLng.latitude,
              'longitude': event.latLng.longitude,
            },
            options: Options(headers: {
              'Authorization': 'Bearer $token',
            }));

        if (response.statusCode == 200) {
          if (event.context.mounted) {
            CustomSnackBar.show(
                message: response.data['message'],
                icon: Icons.done,
                context: event.context);
          }
          emit(AmbulanceSuccessState());
        }
      } on DioException catch (e) {
        log(e.toString());
        if (event.context.mounted) {
          CustomSnackBar.show(
              message: e.response!.data['message'],
              icon: Icons.error,
              context: event.context);
        }
        emit(AmbulanceEditState());
      } finally {
        emit(AmbulanceInitial());
      }
    });
  }

  Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }
}
