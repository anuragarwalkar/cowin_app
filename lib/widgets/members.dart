import 'package:cowin_app/http/appHttp.dart';
import 'package:cowin_app/utils/home_page_controller.dart';
import 'package:cowin_app/widgets/appSpinner.dart';
import 'package:flutter/material.dart';

class Members extends StatefulWidget {
  final HomePageController controller;
  Members({Key key, this.controller}) : super(key: key);
  @override
  _MembersState createState() => _MembersState(controller);
}

class _MembersState extends State<Members> {
  _MembersState(HomePageController _controller) {
    _controller.getMemmbersSub = getMembersFromApi;
  }
  List<dynamic> _benificiaries = [];

  @override
  void initState() {
    getMembersFromApi();
    super.initState();
  }

  getMembersFromApi() {
    getMembers().then((value) {
      print(value);
      this.setState(() {
        this._benificiaries = value['beneficiaries'];
        _showSpinner = false;
      });
    }).catchError((err) {
      this.setState(() {
        _showSpinner = false;
      });
    });
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
