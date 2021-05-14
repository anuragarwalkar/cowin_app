import 'package:cowin_app/http/appHttp.dart';
import 'package:cowin_app/widgets/appSpinner.dart';
import 'package:flutter/material.dart';

class Members extends StatefulWidget {
  Members({Key key}) : super(key: key);
  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  List<dynamic> _benificiaries = [];
  @override
  void initState() {
    getMembers().then((value) {
      this.setState(() {
        this._benificiaries = value['beneficiaries'];
        _showSpinner = false;
      });
    }).catchError((err) {
      this.setState(() {
        _showSpinner = false;
      });
    });
    super.initState();
  }

  Widget _mainColumn() {
    return Column(
      children: [
        ..._benificiaries.map<Widget>((e) => Container(
              width: double.infinity,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(e['name']),
                      Text(e['birth_year']),
                      Text(
                        e['gender'],
                      )
                    ],
                  ),
                ),
              ),
            ))
      ],
    );
  }

  bool _showSpinner = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _showSpinner ? null : double.infinity,
      padding: EdgeInsets.all(10),
      child: _showSpinner ? Spinner() : _mainColumn(),
    );
  }
}
