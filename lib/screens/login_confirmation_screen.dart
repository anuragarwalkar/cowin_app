import 'dart:async';
import 'dart:convert';

import 'package:cowin_app/http/appHttp.dart';
import 'package:cowin_app/screens/home_screen.dart';
import 'package:cowin_app/widgets/appPinCodeFields.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginConfirmationScreen extends StatefulWidget {
  static const routeName = 'login-confirmation';

  @override
  _LoginConfirmationScreenState createState() =>
      _LoginConfirmationScreenState();
}

class _LoginConfirmationScreenState extends State<LoginConfirmationScreen> {
  StreamController<ErrorAnimationType> _errorController;
  bool _hasError = false;

  String _errorMessage;
  Digest _otp;

  @override
  void dispose() {
    if (_errorController != null) {
      _errorController.close();
    }

    super.dispose();
  }

  void _onCompleted(String text) {
    var bytes = utf8.encode(text); // data being hashed

    var digest = sha256.convert(bytes);
    print(digest);
    this.setState(() {
      _hasError = false;
      _otp = digest;
    });
  }

  void _onChanged(String text) {
    print(text);
  }

  @override
  void initState() {
    _errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  _confirmOtp() async {
    if (_otp != null) {
      try {
        var res = await confirmOtp(_otp.toString());
        if (res == true) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
        }
        print(res);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm OTP'),
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppPinCodeFields(
              context: context,
              errorController: _errorController,
              onChanged: _onChanged,
              onCompleted: _onCompleted,
              hasError: _hasError,
            ),
            ElevatedButton(
              onPressed: _confirmOtp,
              child: Text('Confirm'),
            )
          ],
        ),
      ),
    );
  }
}
