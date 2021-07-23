import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

setString(String key, String value) async {
  await storage.write(key: key, value: value);
}

getString(String key) async {
  return await storage.read(key: key);
}
