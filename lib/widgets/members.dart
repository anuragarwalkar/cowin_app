import 'package:cowin_app/http/appHttp.dart';
import 'package:flutter/material.dart';

class Members extends StatefulWidget {
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
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
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
      ),
    );
  }
}
