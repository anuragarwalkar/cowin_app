import 'dart:async';
import 'dart:convert';

import 'package:cowin_app/http/appHttp.dart';
import 'package:cowin_app/screens/first_screen.dart';
import 'package:cowin_app/screens/home_screen.dart';
import 'package:cowin_app/storage/localStorage.dart';
import 'package:cowin_app/utils/colors.dart';
import 'package:cowin_app/utils/utilFunctions.dart';
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
  TextEditingController _textEditingController = TextEditingController();

  // String _errorMessage;
  Digest _otp;
  int _counter = 180;
  Timer _timer;

  void _startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    setState(() {
      _hasError = false;
    });

    _counter = 180;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          if (_timer != null) {
            _timer.cancel();
            // _hasError = true;
          }
        }
      });
    });
  }

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

  void _onChanged(String text) {}

  @override
  void initState() {
    _startTimer();
    _errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  _getnerateOtp({resend = false}) async {
    _textEditingController.clear();
    _startTimer();
    int phone = ls.getInt('phone');

    if (phone != null) {
      await generateOtp(phone);
    }
    if (resend) {
      showSnackbar(
        context: context,
        message: 'OTP resent on your phone +91-${phone.toString()}',
      );
    }
  }

  _confirmOtp() async {
    if (_otp != null) {
      this.setState(() {
        _hasError = false;
      });
      try {
        var res = await confirmOtp(_otp.toString());
        if (res == true) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
        }
      } catch (e) {
        _errorController.add(ErrorAnimationType.shake);
        this.setState(() {
          _hasError = true;
        });
        print(e);
      }
    }
  }

  _navigateToLogin() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(FirstScreen.routeName, (route) => false);
  }

// 180 seconds
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 10,
            ),
            if (ls.getInt('phone') != null)
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('+91-${ls.getInt('phone').toString()}'),
                TextButton(
                  onPressed: _navigateToLogin,
                  child: Text('Edit Phone'),
                ),
              ]),
            SizedBox(
              height: 50,
            ),
            AppPinCodeFields(
              editingController: _textEditingController,
              context: context,
              errorController: _errorController,
              onChanged: _onChanged,
              onCompleted: _onCompleted,
              hasError: _hasError,
            ),
            Text(
              _counter.toString(),
              style: TextStyle(color: appPrimaryColor),
            ),
            SizedBox(
              height: 30,
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
            TextButton(
              onPressed: () => _getnerateOtp(resend: true),
              child: Text('Resend OTP'),
            )
          ],
        ),
      ),
    );
  }
}
