import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:i_am_driver/utils/config.dart';
import 'package:i_am_driver/utils/custim_snack_bar.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final dio = Dio();
  BookingBloc() : super(BookingInitial()) {
    on<UpdateBookingEvent>((event, emit) async {
      emit(BookingLoading());

      try {
        final token = await getToken();
        final response = await dio.patch(
          Config.bookingListUrl + '/${event.bookingId}',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }),
        );

        if (response.statusCode == 200) {
          emit(BookingSuccess());
          if (event.context.mounted) {
            CustomSnackBar.show(
              message: response.data['message'],
              icon: Icons.check,
              context: event.context,
            );
          }
        }
      } on DioException catch (e) {
        log(e.toString());
        if (event.context.mounted) {
          CustomSnackBar.show(
            message: e.response?.data['message'],
            icon: Icons.error,
            context: event.context,
          );
        }
      } finally {
        emit(BookingInitial());
      }
    });
  }

  Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }
}
