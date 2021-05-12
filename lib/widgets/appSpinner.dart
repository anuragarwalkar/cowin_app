import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  Widget _spinner() {
    return Center(
      child: Container(
        height: 25,
        width: 25,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _spinner();
  }
}
