import 'package:flutter/material.dart';

class AppCentersCard extends StatelessWidget {
  final Map item;
  AppCentersCard(this.item);

  List<Widget> _getAvalability(Map item) {
    List sessions = item['sessions'];
    int slots = sessions.first['available_capacity'];
    String label = slots > 0 ? 'Oepn' : 'Booked';
    return [
      Chip(
        label: Text(label),
        backgroundColor: slots > 0 ? Colors.green : Colors.red,
      ),
      if (slots > 0)
        Chip(
          label: Text('Slots ${slots.toString()}'),
          backgroundColor: Colors.green,
        ),
    ];
  }

  Widget _getVaccine(Map item) {
    List sessions = item['sessions'];
    String vaccine = sessions.first['vaccine'];
    return Chip(
      label: Text(vaccine),
    );
  }

  Widget _getAge(Map item) {
    List sessions = item['sessions'];
    int age = sessions.first['min_age_limit'];
    return Chip(
      label: Text('Age $age +'),
    );
  }

  Widget _getIconWithText(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            text,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getIconWithText(Icons.local_hospital, item['name']),
                  _getIconWithText(Icons.location_city, item['address']),
                  _getIconWithText(Icons.pin_drop, item['pincode'].toString()),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _getVaccine(item),
                      SizedBox(width: 10),
                      _getAge(item),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ..._getAvalability(item),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
