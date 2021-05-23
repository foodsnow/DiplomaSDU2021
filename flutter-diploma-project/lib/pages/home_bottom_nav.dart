import 'package:diploma_flutter_app/pages/edit/burnout_page.dart';
import 'package:diploma_flutter_app/pages/favorites/favorites_page.dart';
import 'package:diploma_flutter_app/pages/notification/notification_page.dart';
import 'package:diploma_flutter_app/pages/profile/profile_page.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home/home_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    BurnOutPage(),
    FavoritesPage(),
    NotificationPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: CustomColors.White,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/home_inactive_icon.svg'),
            label: 'Home',
            activeIcon: SvgPicture.asset(
              'assets/icons/home_active_icon.svg',
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/burn_inactive_icon.svg'),
            label: 'Edit',
            activeIcon: SvgPicture.asset(
              'assets/icons/burn_active_icon.svg',
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/favorites_inactive_icon.svg'),
            label: 'Favorites',
            activeIcon: SvgPicture.asset(
              'assets/icons/favorites_active_icon.svg',
            ),
          ),
          BottomNavigationBarItem(
            icon:
                SvgPicture.asset('assets/icons/notification_inactive_icon.svg'),
            label: 'Notification',
            activeIcon: SvgPicture.asset(
              'assets/icons/notification_active_icon.svg',
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/profile_inactive_icon.svg'),
            label: 'Profile',
            activeIcon: SvgPicture.asset(
              'assets/icons/profile_active_icon.svg',
            ),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
