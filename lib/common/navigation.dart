import 'package:flutter/material.dart';
import 'package:restaurant_app/page/home_page.dart';
import 'package:restaurant_app/page/search_page.dart';
import 'package:restaurant_app/page/setting_page.dart';

import 'styles.dart';

class Navigation extends StatefulWidget {

  static const routeName = '/navigation';

  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _bottomNavIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: "Search",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Setting",
    ),
  ];

  final List<Widget> _listWidget = [
    const HomePage(),
    const SearchPage(),
    const SettingPage()
  ];
}
