import 'package:cowin_app/http/appHttp.dart';
import 'package:cowin_app/utils/utilFunctions.dart';
import 'package:cowin_app/widgets/appCentersCard.dart';
import 'package:cowin_app/widgets/appSpinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class CentersByPin extends StatefulWidget {
  @override
  _CentersByPinState createState() => _CentersByPinState();
}

class _CentersByPinState extends State<CentersByPin> {
  final _formKey = GlobalKey<FormState>();
  bool _showSpinner = false;
  List _centers = [];

  final TextEditingController _pinCode = TextEditingController();

  _onSearch() async {
    setState(() {
      _centers = [];
      _showSpinner = true;
    });
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState.validate()) {
      List centers = await getCentersByPin(_pinCode.text, formatedDate);
      setState(() {
        _centers = centers;
        _showSpinner = false;
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
            onFieldSubmitted: (val) => _onSearch(),
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
            child: _showSpinner
                ? Spinner()
                : _centers.isEmpty
                    ? Center(
                        child: Text(
                          'Centers Not Found ' +
                              '${_pinCode.value.text != "" ? "for " + _pinCode.value.text : ""}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _centers.length,
                        itemBuilder: (ctx, index) {
                          return AppCentersCard(_centers[index]);
                        },
                      ),
          )
        ]),
      ),
    );
  }
}
