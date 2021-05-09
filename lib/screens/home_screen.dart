import 'package:cowin_app/widgets/appBottomNavigation.dart';
import 'package:cowin_app/widgets/available_slots.dart';
import 'package:cowin_app/widgets/members.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 0;
  void _selectPage(int page) {
    setState(() {
      _selectedPageIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        _selectedPageIndex == 0 ? 'Members' : 'Avalable slots',
      )),
      body: Container(
        child: _selectedPageIndex == 0 ? Members() : AvailableSlots(),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        isLoggedIn: true,
        selectPage: _selectPage,
        selectedPageIndex: _selectedPageIndex,
      ),
    );
  }
}
