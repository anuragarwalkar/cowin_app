import 'dart:convert';
import 'dart:io';

import 'package:cowin_app/storage/localStorage.dart';
import 'package:http/http.dart' as http;

String _baseUrl = 'cdn-api.co-vin.in';

String _genOtp = 'auth/generateMobileOTP';
String _conOtp = 'auth/validateMobileOtp';

Uri genUrl(String url) {
  return Uri.https(_baseUrl, 'api/v2/' + url);
}

final _headers = {
  HttpHeaders.contentTypeHeader: "application/json",
  HttpHeaders.acceptHeader: "application/json",
};

Future<bool> generateOtp(int mobileNumber) async {
  print(mobileNumber);
  Map reqBody = {
    "secret":
        "U2FsdGVkX1/Haasm5iWyBo3n3rDUbdRe+AUrekPbew2T8lpZBleL54n+TX1fd9Rr9xUs/aRKYcVtwcgdD8+zKw==",
    "mobile": mobileNumber
  };

  http.Response res = await http.post(
    genUrl(_genOtp),
    headers: _headers,
    body: json.encode(
      reqBody,
    ),
  );
  return await ls.setMap('txnId', json.decode(res.body)['txnId']);
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

    print(res.body);
    await ls.setMap('token_time', DateTime.now().toString());
    return await ls.setMap('token', json.decode(res.body)['token']);
  } catch (e) {
    Future.error(e);
  }
}
