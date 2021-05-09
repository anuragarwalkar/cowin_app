import 'package:cowin_app/screens/login_screen.dart';
import 'package:cowin_app/widgets/appBottomNavigation.dart';
import 'package:cowin_app/widgets/available_slots.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  static const routeName = 'first-screen';
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  void _selctPage(int index) {
    this.setState(() {
      this._selectedPageIndex = index;
    });
  }

  int _selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedPageIndex == 0 ? 'Login/Register' : 'Available Slots',
        ),
      ),
      body: _selectedPageIndex == 0 ? LoginScreen() : AvailableSlots(),
      bottomNavigationBar: AppBottomNavigationBar(
        selectPage: _selctPage,
        selectedPageIndex: _selectedPageIndex,
      ),
    );
  }
}
