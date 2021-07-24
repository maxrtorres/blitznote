import 'package:flutter/material.dart';
import 'package:notes_app/utilities/biometric_util.dart' as BiometricUtil;
import 'package:notes_app/values/my_colors.dart';
import 'package:notes_app/values/routes.dart';
import 'package:notes_app/values/strings.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.colorPrimary,
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
              child: Container(
            margin: new EdgeInsets.symmetric(vertical: 40),
            child: Text(Strings.appTitle,
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w300,
                    color: MyColors.whiteColor)),
          )),
          Center(
              child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyColors.colorLight),
            onPressed: () async {
              bool success = await BiometricUtil.checkBiometrics(context);
              if (success) {
                Navigator.pushReplacementNamed(context, Routes.homeRoute);
              }
            },
            child: Text(Strings.continueButton,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w100,
                    color: MyColors.whiteColor)),
          )),
        ]));
  }
}
