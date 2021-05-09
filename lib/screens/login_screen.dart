import 'package:cowin_app/http/appHttp.dart';
import 'package:cowin_app/screens/login_confirmation_screen.dart';
import 'package:flutter/material.dart';

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
      var res = await generateOtp(int.parse(phoneNumber.value.text));

      if (res) {
        Navigator.of(context).pushNamed(LoginConfirmationScreen.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (val) => _validator(val),
                controller: phoneNumber,
                decoration: InputDecoration(
                  labelText: 'Your Phone Number',
                  icon: Icon(Icons.phone),
                  hintText: 'Your Mobile',
                ),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(onPressed: _onLogin, child: Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}
