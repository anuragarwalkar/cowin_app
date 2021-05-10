import 'dart:async';

import 'package:cowin_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppPinCodeFields extends StatelessWidget {
  final onChanged;
  final onCompleted;
  final hasError;
  final TextEditingController editingController;
  final StreamController<ErrorAnimationType> errorController;

  final BuildContext context;
  AppPinCodeFields({
    @required this.onChanged,
    @required this.onCompleted,
    @required this.context,
    @required this.errorController,
    this.editingController,
    @required this.hasError,
  });
  @override
  Widget build(BuildContext ctx) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 70,
        fieldWidth: 50,
        activeFillColor: Colors.white,
        inactiveColor: Colors.grey.shade400,
        selectedFillColor: Colors.white,
        activeColor: appPrimaryColor,
        inactiveFillColor: hasError ? Colors.red.shade100 : Colors.white,
        selectedColor: appPrimaryColor,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      animationDuration: Duration(milliseconds: 300),
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      onCompleted: onCompleted,
      appContext: context,
      errorAnimationController: errorController,
      controller: editingController,
      beforeTextPaste: (text) {
        return true;
      },
      onChanged: onChanged,
    );
  }
}
