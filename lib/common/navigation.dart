import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/setting_page.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation extends StatefulWidget {

  static const routeName = '/navigation';

  const Navigation({super.key});

  static intentWithData(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static back() => navigatorKey.currentState?.pop();

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  int _bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
        RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
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
      label: "Beranda",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: "Cari",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Pengaturan",
    ),
  ];

  final List<Widget> _listWidget = [
    const HomePage(),
    SearchPage(),
    const SettingPage()
  ];
}
