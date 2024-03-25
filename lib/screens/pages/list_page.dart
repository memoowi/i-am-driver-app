import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_driver/bloc/booking_list_bloc.dart';
import 'package:i_am_driver/screens/pages/tabs/history_tabs.dart';
import 'package:i_am_driver/screens/pages/tabs/ongoing_tabs.dart';
import 'package:i_am_driver/utils/theme.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int _value = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Ongoing',
      'widget': OngoingTabs(),
    },
    {
      'title': 'History',
      'widget': HistoryTabs(),
    },
  ];

  @override
  void initState() {
    super.initState();
    context.read<BookingListBloc>().add(FetchBookingList());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<BookingListBloc>().add(FetchBookingList());
      },
      edgeOffset: 100.0,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast,
        ),
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            toolbarHeight: 64.0,
            title: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                CircleAvatar(
                  radius: 24,
                  foregroundImage: AssetImage('assets/profile-2.png'),
                ),
                SizedBox(),
                ...List<Widget>.generate(
                  _pages.length,
                  (int index) {
                    return ChoiceChip(
                      selectedColor: CustomColors.primaryColor,
                      checkmarkColor: CustomColors.lightColor,
                      label: Text('${_pages[index]['title']}'),
                      labelStyle: index == _value
                          ? CustomTextStyles.light.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            )
                          : CustomTextStyles.dark.copyWith(
                              fontSize: 14.0,
                            ),
                      selected: _value == index,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = index;
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  padding: EdgeInsets.only(bottom: 100.0),
                  child: BlocBuilder<BookingListBloc, BookingListState>(
                    builder: (context, state) {
                      if (state is BookingListLoading ||
                          state is BookingListInitial) {
                        return LinearProgressIndicator();
                      }
                      return _pages[_value]['widget'];
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
