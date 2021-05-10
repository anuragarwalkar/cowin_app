import 'package:cowin_app/http/appHttp.dart';
import 'package:cowin_app/screens/login_confirmation_screen.dart';
import 'package:cowin_app/storage/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumber = TextEditingController();

  _validator(dynamic text) {
    if (text.length < 10) {
      return 'Please add valid phone number';
    }

    return null;
  }

  _onLogin() async {
    if (_formKey.currentState.validate()) {
      print(phoneNumber.value.text);
      try {
        int phone = int.parse(phoneNumber.value.text);
        var res = await generateOtp(phone);
        if (res) {
          await ls.setInt('phone', phone);
          ls.setIsLogin();
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
            ),
            SizedBox(
              height: 50,
            ),
            TextFormField(
              validator: (val) => _validator(val),
              controller: phoneNumber,
              decoration: InputDecoration(
                labelText: 'Your Phone Number',
                icon: Icon(Icons.phone),
                hintText: 'Your Mobile',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onFieldSubmitted: (String val) => _onLogin(),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: _onLogin,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  child: Text(
                    'Get OTP',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
