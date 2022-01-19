import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:notes_app/utilities/storage_util.dart' as StorageUtil;
import 'package:notes_app/values/keys.dart';
import 'package:notes_app/values/my_colors.dart';
import 'package:notes_app/values/strings.dart';

final localAuth = LocalAuthentication();

Future<bool> checkBiometrics(context) async {
  if (await isEnrolledBiometrics()) {
    return await authenticateWithBiometrics();
  }
  if (await hasBiometricHardware()) {
    await enrollBiometrics(context);
  }
  return true;
}

isEnrolledBiometrics() async {
  return await StorageUtil.getString(Keys.isEnrolledBiometrics) == 'true';
}

hasBiometricHardware() async {
  return await localAuth.canCheckBiometrics;
}

enrollBiometrics(context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Enable biometric authentication?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () async {
              await StorageUtil.setString(Keys.isEnrolledBiometrics, 'true');
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('No', style: TextStyle(color: MyColors.redColor)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

authenticateWithBiometrics() async {
  bool success = false;
  try {
    success = await localAuth.authenticate(
        localizedReason: 'Authenticate with biometrics', biometricOnly: true);
  } catch (e) {
    Fluttertoast.showToast(
        msg: Strings.missingBiometricsError,
        toastLength: Toast.LENGTH_LONG,
        fontSize: 16.0);
  }
  return success;
}
