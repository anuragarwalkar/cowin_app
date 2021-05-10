import 'package:cowin_app/http/appHttp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CentersByPin extends StatefulWidget {
  @override
  _CentersByPinState createState() => _CentersByPinState();
}

class _CentersByPinState extends State<CentersByPin> {
  final _formKey = GlobalKey<FormState>();
  List _centers = [];

  final TextEditingController _pinCode = TextEditingController();

  _onSearch() async {
    if (_formKey.currentState.validate()) {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formattedDate = formatter.format(DateTime.now());
      List centers = await getCentersByPin(_pinCode.text, formattedDate);
      setState(() {
        _centers = centers;
      });
    }
  }

  Widget _searchCenters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: 70,
          child: TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.pin_drop),
              hintText: 'Pin Code',
              labelText: 'Your 6 Digit Pin Code',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            controller: _pinCode,
            onSaved: (String value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String value) {
              value = value.trim();
              return value != "" && value.length == 6
                  ? null
                  : 'Please enter valid Pin Code';
            },
          ),
        ),
        SizedBox(
          width: 30,
        ),
        SizedBox(
          child: ElevatedButton(
            child: Text('Search'),
            onPressed: _onSearch,
          ),
        )
      ],
    );
  }

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
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(children: [
          _searchCenters(),
          Container(
            height: MediaQuery.of(context).size.height * 0.62,
            child: ListView(
              children: [
                ..._centers.map(
                  (e) => Card(
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
                                _getIconWithText(
                                    Icons.local_hospital, e['name']),
                                _getIconWithText(
                                    Icons.location_city, e['address']),
                                _getIconWithText(
                                    Icons.pin_drop, e['pincode'].toString()),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _getVaccine(e),
                                    SizedBox(width: 10),
                                    _getAge(e),
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
                                ..._getAvalability(e),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
