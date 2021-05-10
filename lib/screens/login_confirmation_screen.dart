import 'dart:async';
import 'dart:convert';

import 'package:cowin_app/http/appHttp.dart';
import 'package:cowin_app/screens/home_screen.dart';
import 'package:cowin_app/storage/localStorage.dart';
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

  // String _errorMessage;
  Digest _otp;

  @override
  void dispose() {
    if (_errorController != null) {
      _errorController.close();
    }

    super.dispose();
  }

  void _onCompleted(String text) {
    this.setState(() {
      _hasError = false;
      _otp = _convertSHA256(text);
    });
  }

  Digest _convertSHA256(String text) {
    var bytes = utf8.encode(text); // data being hashed

    return sha256.convert(bytes);
  }

  void _onChanged(String text) {
    print(text);
  }

  @override
  void initState() {
    int phone = ls.getInt('phone');
    if (phone != null) {
      // generateOtp(phone).then((value) => null);
    }
    _errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  _confirmOtp({Digest otp}) async {
    if (otp == null) {
      otp = _otp;
    }

    if (otp != null) {
      try {
        var res = await confirmOtp(otp.toString());
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
        title: Text('OTP Verification'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'OTP Verification',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'You will get OTP via sms',
            ),
            SizedBox(
              height: 50,
            ),
            AppPinCodeFields(
              context: context,
              errorController: _errorController,
              onChanged: _onChanged,
              onCompleted: _onCompleted,
              hasError: _hasError,
            ),
            ElevatedButton(
              onPressed: _confirmOtp,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 50,
                ),
                child: Text('Confirm'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
