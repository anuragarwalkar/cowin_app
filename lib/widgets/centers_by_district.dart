import 'package:cowin_app/http/appHttp.dart';
import 'package:cowin_app/utils/utilFunctions.dart';
import 'package:cowin_app/widgets/appCentersCard.dart';
import 'package:cowin_app/widgets/appSpinner.dart';
import 'package:flutter/material.dart';

class CentersByDistrict extends StatefulWidget {
  @override
  _CentersByDistrictState createState() => _CentersByDistrictState();
}

class _CentersByDistrictState extends State<CentersByDistrict> {
  List _states = [];
  List _district = [];
  List _centers = [];

  String _selectedStateId;
  String _selectedDistrictId;
  bool _showLoader = true;

  @override
  void initState() {
    initData().then((res) => null);
    // TODO: implement initState
    super.initState();
  }

  Future<void> initData() async {
    var states = await getStates();
    setState(() {
      _states = states.cast();
    });
  }

  _onSelectState(val) async {
    getDistrict(val).then((district) {
      setState(() {
        _district = district;
      });
    });
    this.setState(() {
      _selectedStateId = val;
    });
  }

  _onSelectDistrict(val) async {
    this.setState(() {
      _selectedDistrictId = val;
    });
    await _fetchCenters(val);
  }

  _fetchCenters(String center) async {
    this.setState(() {
      _centers = [];
      _showLoader = true;
    });
    var centers = await getCenterByDistrict(center, formatedDate);
    this.setState(() {
      _centers = centers;
      _showLoader = false;
    });
  }

  _onPressed() async {
    if (_selectedDistrictId != null) {
      await _fetchCenters(_selectedDistrictId);
    }
  }

  List<Widget> _searchByDistrict() {
    return [
      DropdownButtonFormField(
        hint: Text('Select State'),
        onChanged: _onSelectState,
        value: _selectedStateId,
        items: _states
            .map(
              (e) => DropdownMenuItem(
                child: Text(
                  e['state_name'],
                ),
                value: e['state_id'].toString(),
              ),
            )
            .toList(),
      ),
      SizedBox(
        height: 25,
      ),
      if (_district.isNotEmpty)
        DropdownButtonFormField(
          hint: Text('Select District'),
          onChanged: _onSelectDistrict,
          value: _selectedDistrictId,
          items: _district
              .map(
                (e) => DropdownMenuItem(
                  child: Text(
                    e['district_name'],
                  ),
                  value: e['district_id'].toString(),
                ),
              )
              .toList(),
        ),
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
        ),
        child: ElevatedButton(
          onPressed: _selectedDistrictId != null && _selectedStateId != null
              ? _onPressed
              : null,
          child: Text('Search'),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Form(
          child: ListView(
        shrinkWrap: true,
        children: [
          ..._searchByDistrict(),
          if (_centers.isNotEmpty)
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: _showLoader && _selectedDistrictId != null
                  ? Spinner()
                  : ListView.builder(
                      itemCount: _centers.length,
                      itemBuilder: (context, index) {
                        return AppCentersCard(_centers[index]);
                      },
                    ),
            )
        ],
      )),
    );
  }
}
