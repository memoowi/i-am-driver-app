import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_am_driver/screens/pages/list_page.dart';
import 'package:i_am_driver/screens/pages/pending_page.dart';
import 'package:i_am_driver/screens/pages/profile_page.dart';
import 'package:i_am_driver/utils/theme.dart';

class MainScreen extends StatefulWidget {
  final int index;
  const MainScreen({
    super.key,
    this.index = 0,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final NotchBottomBarController notchBottomBarController =
      NotchBottomBarController();

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentIndex = widget.index;
    });
    notchBottomBarController.index = _currentIndex;
    _pageController =
        PageController(initialPage: _currentIndex); // Set initial page
  }

  @override
  void dispose() {
    notchBottomBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        forceMaterialTransparency: true,
      ),
      extendBodyBehindAppBar: true,
      body: PageView(
        controller: _pageController,
        children: [
          PendingPage(),
          ListPage(),
          Container(
            color: CustomColors.darkColor,
          ),
          ProfilePage(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
          notchBottomBarController.index = _currentIndex;
        },
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        onTap: (value) {
          _pageController.jumpToPage(
            value,
          );
          setState(() {
            _currentIndex = value;
          });
        },
        notchBottomBarController: notchBottomBarController,
        showBlurBottomBar: true,
        blurOpacity: 1,
        durationInMilliSeconds: 200,
        kIconSize: 22,
        kBottomRadius: 20,
        showLabel: false,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              CupertinoIcons.bell,
              color: CustomColors.darkColor,
            ),
            activeItem: Icon(
              CupertinoIcons.bell_fill,
              color: CustomColors.primaryColor,
            ),
            itemLabel: 'Waitlist',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              CupertinoIcons.square_list,
              color: CustomColors.darkColor,
            ),
            activeItem: Icon(
              CupertinoIcons.square_list_fill,
              color: CustomColors.primaryColor,
            ),
            itemLabel: 'History',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              CupertinoIcons.bus,
              color: CustomColors.darkColor,
            ),
            activeItem: Icon(
              CupertinoIcons.bus,
              color: CustomColors.primaryColor,
            ),
            itemLabel: 'Ambulance',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              CupertinoIcons.person,
              color: CustomColors.darkColor,
            ),
            activeItem: Icon(
              CupertinoIcons.person_fill,
              color: CustomColors.primaryColor,
            ),
            itemLabel: 'Profile',
          ),
        ],
      ),
    );
  }
}
