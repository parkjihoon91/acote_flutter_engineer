
import 'package:flutter/material.dart';

import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            AlarmScreen(),
            SearchScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapBottomNavigation,
        items: [
          createBottomNaviItem(
            icon: const Icon(Icons.home),
            label: '홈',
          ),
          createBottomNaviItem(
            icon: const Icon(Icons.add_alert_outlined),
            label: '알림',
          ),
          createBottomNaviItem(
            icon: const Icon(Icons.search),
            label: '탐색',
          ),
          createBottomNaviItem(
            icon: const Icon(Icons.supervised_user_circle),
            label: '프로필',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void onTapBottomNavigation(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  BottomNavigationBarItem createBottomNaviItem({
    required Icon icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }

}