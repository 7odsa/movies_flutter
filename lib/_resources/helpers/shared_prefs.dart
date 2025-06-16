import 'package:shared_preferences/shared_preferences.dart';

sealed class SharedPrefs {
  static const l10nKey = 'l10n';
  static late SharedPreferences _sharedPrefs;
  static Future<void> initSharedPrefs() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  static String getL10n() {
    return _sharedPrefs.getString(l10nKey) ?? 'en';
  }

  static Future<String> toggle(String prevL10n) async {
    final newl10n = prevL10n == 'ar' ? 'en' : 'ar';
    await _sharedPrefs.setString(l10nKey, newl10n);
    return newl10n;
  }
}
