import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PreferenceHelper {
  static String accessToken = 'accessToken';

  static const storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  static Future<void> _setPreference(String key, dynamic value) async {
    await storage.write(key: key, value: value.toString());
  }

  //General preference
  static Future<void> setAccessToken({required String accessToken}) async {
    await _setPreference(accessToken, accessToken);
  }

  static Future<String> getAccessToken(String key) async =>
      await _getPreferenceAsString(key);

  static Future<String> _getPreferenceAsString(
    String key,
  ) async =>
      await storage.read(key: key).then((value) {
        if (value == null) return "";
        return value;
      });
}
