import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:i_am_driver/models/booking_list_model.dart';
import 'package:i_am_driver/utils/config.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pending_list_event.dart';
part 'pending_list_state.dart';

class PendingListBloc extends Bloc<PendingListEvent, PendingListState> {
  final dio = Dio();
  PendingListBloc() : super(PendingListInitial()) {
    on<FetchPendingList>((event, emit) async {
      emit(PendingListLoading());

      try {
        final token = await getToken();
        final response = await dio.get(Config.pendingListUrl,
            options: Options(headers: {
              'Authorization': 'Bearer $token',
            }));

        if (response.statusCode == 200) {
          final pendingList = BookingListModel.fromJson(response.data);
          emit(PendingListLoaded(data: pendingList));
        }
      } on DioException catch (e) {
        log(e.toString());
        emit(PendingListInitial());
      }
    });
  }
  Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }
}
