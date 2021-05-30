import 'package:flutter/material.dart';

class AppCentersCard extends StatelessWidget {
  final Map item;
  AppCentersCard(this.item);

  List<Widget> _getAvalability(Map item) {
    List sessions = item['sessions'];

    Map data = {'18': 0, '45': 0};

    sessions.forEach((element) {
      int count = data[element['min_age_limit']];
      int capacity = element['available_capacity'];
      if (count != null && capacity != null) {
        data[element['min_age_limit']] = count + capacity;
      }
    });

    return [
      Chip(
        label: Text('Age 18+ Slots 0'),
        backgroundColor: data['18'] > 0 ? Colors.green : Colors.red,
      ),
      Chip(
        label: Text('Age 45+ Slots 0'),
        backgroundColor: data['45'] > 0 ? Colors.green : Colors.red,
      )
    ];
  }

  List<Widget> _getVaccine(Map item) {
    List sessions = item['sessions'];
    var vaccines = <String>{};
    sessions.forEach((session) {
      vaccines.add(session['vaccine']);
    });

    return vaccines
        .map((vaccine) => Container(
              margin: EdgeInsets.only(right: 10),
              child: Chip(
                label: Text(vaccine),
              ),
            ))
        .toList();
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
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getIconWithText(Icons.local_hospital, item['name']),
                      _getIconWithText(Icons.location_city, item['address']),
                      _getIconWithText(
                          Icons.pin_drop, item['pincode'].toString()),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._getAvalability(item),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: _getVaccine(item),
            )
          ],
        ),
      ),
    );
  }
}
