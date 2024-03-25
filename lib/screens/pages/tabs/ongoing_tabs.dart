import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_driver/bloc/booking_list_bloc.dart';
import 'package:i_am_driver/models/booking_list_model.dart';
import 'package:i_am_driver/utils/theme.dart';
import 'package:i_am_driver/widgets/custom_expand_tile.dart';

class OngoingTabs extends StatelessWidget {
  const OngoingTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingListBloc, BookingListState>(
      builder: (context, state) {
        final BookingListModel? rawData =
            (state is BookingListLoaded) ? state.bookingList : null;
        final ongoingData = rawData!.data!
            .where((element) =>
                element.status == 'accepted' || element.status == 'picked')
            .toList();
        if (ongoingData.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'No Ongoing Orders...',
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
          itemCount: ongoingData.length,
          itemBuilder: (BuildContext context, int index) {
            final data = ongoingData[index];
            return CustomExpandTile(
              status: (data.status == 'accepted')
                  ? StatusType.accepted
                  : (data.status == 'picked')
                      ? StatusType.picked
                      : StatusType.accepted,
              data: data,
            );
          },
        );
      },
    );
  }
}
