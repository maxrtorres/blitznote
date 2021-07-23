import 'package:local_auth/local_auth.dart';
import 'package:notes_app/utilities/storage_util.dart' as StorageUtil;
import 'package:notes_app/values/keys.dart';

final localAuth = LocalAuthentication();

Future<bool> authenticate() async {
  if (await isEnrolledBiometrics()) {
    await authenticateWithBiometrics();
  } else if (await hasBiometrics()) {
    await enrollBiometrics();
  }

  return false;
}

isEnrolledBiometrics() async {
  return await StorageUtil.getString(Keys.isEnrolledBiometrics) == 'true';
}

hasBiometrics() async {
  return await localAuth.canCheckBiometrics;
}

enrollBiometrics() async {}

authenticateWithBiometrics() async {}
