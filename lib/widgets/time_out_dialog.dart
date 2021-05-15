import 'package:cowin_app/http/appHttp.dart';
import 'package:cowin_app/screens/login_confirmation_screen.dart';
import 'package:cowin_app/storage/localStorage.dart';
import 'package:flutter/material.dart';

class TimeOutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height / 9,
        child: Column(
          children: [
            Text(
              'Totkn will expire soon click Login',
              style: TextStyle(color: Colors.redAccent),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await generateOtp(ls.getInt('phone'));
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginConfirmationScreen.routeName,
                      (route) => false,
                    );
                  },
                  child: Text('Login'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
