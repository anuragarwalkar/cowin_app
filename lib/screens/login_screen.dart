import 'package:cowin_app/http/appHttp.dart';
import 'package:cowin_app/screens/login_confirmation_screen.dart';
import 'package:cowin_app/storage/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumber = TextEditingController(
      text: ls.getInt('phone') != null ? ls.getInt('phone').toString() : null);

  _onLogin() async {
    if (_formKey.currentState.validate()) {
      try {
        String validPhoneNumber = phoneNumber.value.text;
        if (phoneNumber.value.text.contains('+91')) {
          validPhoneNumber = phoneNumber.value.text.replaceFirst('+91', '');
          print(validPhoneNumber);
        }
        int phone = int.parse(validPhoneNumber);
        var res = await generateOtp(phone);
        if (res) {
          await ls.setInt('phone', phone);
          Navigator.of(context).pushNamed(LoginConfirmationScreen.routeName);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/vaccine.jpg',
              width: 180,
              height: 180,
            ),
            SizedBox(height: 50),
            Text(
              'Register or SignIn for Vaccination',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            PhoneFieldHint(
              controller: phoneNumber,
              decoration: InputDecoration(
                labelText: 'Your Phone Number',
                icon: Icon(Icons.phone),
                hintText: 'Your Mobile',
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: _onLogin,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 10,
                ),
                child: Text(
                  'Get OTP',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
