import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_driver/bloc/pending_list_bloc.dart';
import 'package:i_am_driver/models/booking_list_model.dart';
import 'package:i_am_driver/utils/theme.dart';
import 'package:i_am_driver/widgets/custom_expand_tile.dart';

class PendingPage extends StatelessWidget {
  const PendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PendingListBloc>().add(FetchPendingList());
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pending Orders',
                    style: CustomTextStyles.primaryMadimi.copyWith(
                      fontSize: 20.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<PendingListBloc>().add(FetchPendingList());
                    },
                    icon: Icon(
                      CupertinoIcons.refresh_circled_solid,
                      color: CustomColors.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              BlocBuilder<PendingListBloc, PendingListState>(
                builder: (context, state) {
                  if (state is PendingListLoaded) {
                    final BookingListModel? rawData = state.data;
                    final pendingData = rawData!.data!;
                    if (pendingData.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'No Pending Orders...',
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
                      itemCount: pendingData.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = pendingData[index];
                        return CustomExpandTile(
                          status: StatusType.pending,
                          data: data,
                        );
                      },
                    );
                  } else {
                    return LinearProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
