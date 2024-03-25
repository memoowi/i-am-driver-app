import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_driver/bloc/booking_list_bloc.dart';
import 'package:i_am_driver/models/booking_list_model.dart';
import 'package:i_am_driver/utils/theme.dart';
import 'package:i_am_driver/widgets/custom_expand_tile.dart';

class HistoryTabs extends StatelessWidget {
  const HistoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingListBloc, BookingListState>(
      builder: (context, state) {
        final BookingListModel? rawData =
            (state is BookingListLoaded) ? state.bookingList : null;
        final historyData = rawData!.data!
            .where((element) => element.status == 'completed')
            .toList();
        if (historyData.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'No History Orders...',
                style: CustomTextStyles.grey.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        }
        return ListView.separated(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 10.0),
          itemCount: historyData.length,
          itemBuilder: (BuildContext context, int index) {
            final data = historyData[index];
            return CustomExpandTile(
              status: StatusType.completed,
              data: data,
            );
          },
        );
      },
    );
  }
}
