import 'package:cowin_app/http/appHttp.dart';
import 'package:cowin_app/utils/home_page_controller.dart';
import 'package:cowin_app/widgets/appSpinner.dart';
import 'package:cowin_app/widgets/app_user_details.dart';
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
              height: 140,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            UserDetails(userDetails: e),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Chip(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    backgroundColor: e['vaccination_status'] ==
                                            "Not Vaccinated"
                                        ? Colors.amber
                                        : Colors.green,
                                    label: Text(
                                      e['vaccination_status'],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Chip(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 27),
                                      backgroundColor: Colors.indigo,
                                      label: Text(
                                        'Schedule',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
