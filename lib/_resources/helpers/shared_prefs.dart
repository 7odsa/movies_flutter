import 'package:movies_flutter/_resources/common_state_holders/l10n_sh/cubit/l10n_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

sealed class SharedPrefs {
  static const l10nKey = 'l10n';
  static const userKey = 'user';
  static late SharedPreferences _sharedPrefs;
  static Future<void> initSharedPrefs() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  static String getL10n() {
    return _sharedPrefs.getString(l10nKey) ?? 'en';
  }

  static Future<String> toggle(EnumLang lang) async {
    final newl10n = lang == EnumLang.ar ? 'en' : 'ar';
    await _sharedPrefs.setString(l10nKey, newl10n);
    return newl10n;
  }

  static Future<void> setUserToken(String token) async {
    await _sharedPrefs.setString(userKey, token);
  }

  static String? getUserToken() {
    final token = _sharedPrefs.getString(userKey);
    return token;
  }

  static Future<bool> exitAccount() async {
    final isRemoved = await _sharedPrefs.remove(userKey);
    return isRemoved;
  }
}
