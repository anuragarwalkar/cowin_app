import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final bool isLoggedIn;
  AppBottomNavigationBar({
    @required this.selectPage,
    @required this.selectedPageIndex,
    this.isLoggedIn = false,
  });
  final selectPage;
  final selectedPageIndex;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: selectPage,
      currentIndex: selectedPageIndex,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: isLoggedIn ? 'Members' : 'Register/Login'),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), label: 'Avalable Slots'),
      ],
    );
  }
}
