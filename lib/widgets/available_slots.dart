import 'package:cowin_app/widgets/centers_by_pin.dart';
import 'package:flutter/material.dart';

class AvailableSlots extends StatefulWidget {
  AvailableSlots({Key key}) : super(key: key);
  @override
  _AvailableSlotsState createState() => _AvailableSlotsState();
}

class _AvailableSlotsState extends State<AvailableSlots> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.pin_drop),
                  text: 'Search By PIN',
                ),
                Tab(
                  icon: Icon(Icons.location_city),
                  text: 'Search By District',
                ),
              ],
            ),
            title: Text('Vaccination Center'),
          ),
          body: TabBarView(
            children: [
              CentersByPin(),
              Icon(
                Icons.location_city,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
