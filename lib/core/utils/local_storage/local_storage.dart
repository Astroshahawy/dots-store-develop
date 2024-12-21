// ignore_for_file: avoid_positional_boolean_parameters

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final Storage _cacheHelper = Storage._();
  factory Storage() {
    return _cacheHelper;
  }
  Storage._();

  static SharedPreferences? _sp;

  static Future<void> init() async {
    _sp = await SharedPreferences.getInstance();
  }

  static Future<bool> putString(String key, String value) async {
    return _sp!.setString(key, value);
  }

  static Future<bool> putDouble(String key, double value) async {
    return _sp!.setDouble(key, value);
  }

  static Future<bool> putInt(String key, int value) async {
    return _sp!.setInt(key, value);
  }

  static Future<bool> putBool(String key, bool value) async {
    return _sp!.setBool(key, value);
  }

  static Future<bool> putListOfString(String key, List<String> value) async {
    return _sp!.setStringList(key, value);
  }

  static List<String>? getListOfString(String key) {
    return _sp?.getStringList(key);
  }

  static bool? getBool(String key) {
    return _sp?.getBool(key);
  }

  static int? getInt(String key) {
    return _sp?.getInt(key);
  }

  static double? getDouble(String key) {
    return _sp?.getDouble(key);
  }

  static String? getString(String key) {
    return _sp?.getString(key);
  }

  static Future<bool> remove(String key) async {
    return _sp!.remove(key);
  }

  static Future<bool> clearAllSaved() async {
    return _sp!.clear();
  }
}
