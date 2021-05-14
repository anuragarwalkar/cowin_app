import 'dart:convert';
import 'dart:io';

import 'package:cowin_app/storage/localStorage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

String _baseUrl = 'cdn-api.co-vin.in';

String _genOtp = 'auth/generateMobileOTP';
String _conOtp = 'auth/validateMobileOtp';
String _beneficiaries = 'appointment/beneficiaries';
String _findByPin = 'appointment/sessions/public/calendarByPin';
String _getStates = 'admin/location/states';
String _getDistrict(String stateId) => 'admin/location/districts/$stateId';
String _findByDistrict = 'appointment/sessions/public/calendarByDistrict';
String _getIdTypes = 'registration/beneficiary/idTypes';
String _getGenderType = 'registration/beneficiary/genders';
String _benificiaryRegister = 'registration/beneficiary/new';

Uri genUrl(String url) {
  return Uri.https(_baseUrl, 'api/v2/' + url);
}

Uri genUrlQueryParam(String url, Map<String, String> queryParam) {
  return Uri.https(_baseUrl, 'api/v2/' + url, queryParam);
}

get _headers {
  String savedToken = ls.getMap('token');
  String token = "Bearer " + (savedToken != null ? savedToken : "");
  String applicationJson = "application/json";
  return {
    HttpHeaders.contentTypeHeader: applicationJson,
    HttpHeaders.acceptHeader: applicationJson,
    HttpHeaders.authorizationHeader: token
  };
}

Future<bool> generateOtp(int mobileNumber) async {
  Map reqBody = {
    "secret":
        "U2FsdGVkX1/Haasm5iWyBo3n3rDUbdRe+AUrekPbew2T8lpZBleL54n+TX1fd9Rr9xUs/aRKYcVtwcgdD8+zKw==",
    "mobile": mobileNumber
  };
  try {
    http.Response res = await http.post(
      genUrl(_genOtp),
      headers: _headers,
      body: json.encode(
        reqBody,
      ),
    );
    return await ls.setMap('txnId', json.decode(res.body)['txnId']);
  } catch (e) {
    return Future.error(e);
  }
}

Future<dynamic> confirmOtp(String otp) async {
  String txnId = ls.getMap('txnId');

  Map reqBody = {"otp": otp, "txnId": txnId};
  try {
    http.Response res = await http.post(
      genUrl(_conOtp),
      headers: _headers,
      body: json.encode(
        reqBody,
      ),
    );

    Map parsedRes = json.decode(res.body);
    if (parsedRes['error'] != null) {
      return Future.error(parsedRes['error']);
    }
    await ls.setMap('token_time', DateTime.now().toString());
    return await ls.setMap('token', parsedRes['token']);
  } catch (e) {
    return Future.error(e);
  }
}

Future<dynamic> getMembers() async {
  try {
    http.Response res = await http.get(
      genUrl(_beneficiaries),
      headers: _headers,
    );

    if (res.statusCode != 200) {
      return Future.error(res.body);
    }

    return json.decode(res.body);
  } catch (e) {
    Future.error(e);
  }
}

Future getCentersByPin(String pinCode, String date) async {
  try {
    http.Response res = await http.get(
      genUrlQueryParam(_findByPin, {'pincode': pinCode, 'date': date}),
      headers: _headers,
    );
    if (res.statusCode != 200) {
      return Future.error(res.body);
    }

    return json.decode(res.body)['centers'];
  } catch (e) {
    Future.error(e);
  }
}

Future<List> getCenterByDistrict(String districtId, String date) async {
  try {
    http.Response res = await http.get(
      genUrlQueryParam(
          _findByDistrict, {'district_id': districtId, 'date': date}),
      headers: _headers,
    );
    if (res.statusCode != 200) {
      return Future.error(res.body);
    }

    return json.decode(res.body)['centers'];
  } catch (e) {
    return Future.error(e);
  }
}

Future<List> getStates() async {
  try {
    http.Response res = await http.get(
      genUrl(_getStates),
      headers: _headers,
    );

    if (res.statusCode != 200) {
      return Future.error(res.body);
    }

    return json.decode(res.body)['states'];
  } catch (e) {
    return Future.error(e);
  }
}

Future<List> getDistrict(String stateId) async {
  try {
    http.Response res = await http.get(
      genUrl(_getDistrict(stateId)),
      headers: _headers,
    );
    if (res.statusCode != 200) {
      return Future.error(res.body);
    }

    return json.decode(res.body)['districts'];
  } catch (e) {
    return Future.error(e);
  }
}

Future<List> getIdTypes() async {
  try {
    http.Response res = await http.get(
      genUrl(_getIdTypes),
      headers: _headers,
    );
    if (res.statusCode != 200) {
      return Future.error(res.body);
    }

    return json.decode(res.body)['types'];
  } catch (e) {
    return Future.error(e);
  }
}

Future<List> getGender() async {
  try {
    http.Response res = await http.get(
      genUrl(_getGenderType),
      headers: _headers,
    );
    if (res.statusCode != 200) {
      return Future.error(res.body);
    }
    return json.decode(res.body)['genders'];
  } catch (e) {
    return Future.error(e);
  }
}

Future<dynamic> registerBenificiary(
    {@required String name,
    @required String birthYear,
    @required int genderId,
    @required int photoIdType,
    @required String photoIdNumber}) async {
  Map reqBody = {
    "name": name,
    "birth_year": birthYear,
    "gender_id": genderId,
    "photo_id_type": photoIdType,
    "photo_id_number": photoIdNumber,
    "comorbidity_ind": "Y",
    "consent_version": "1"
  };
  try {
    http.Response res = await http.post(
      genUrl(_benificiaryRegister),
      headers: _headers,
      body: json.encode(
        reqBody,
      ),
    );

    Map parsedRes = json.decode(res.body);
    if (parsedRes['error'] != null) {
      return Future.error(parsedRes['error']);
    }
    return parsedRes['beneficiary_reference_id'];
  } catch (e) {
    return Future.error(e);
  }
}
