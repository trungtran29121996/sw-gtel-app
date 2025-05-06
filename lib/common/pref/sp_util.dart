import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

/// SharedPreferences Util.
class SpUtil {
  static final SpUtil _singleton = SpUtil._();
  static SharedPreferences? _prefs;
  static final Lock _lock = Lock();

  static SpUtil getInstance() {
    return _singleton;
  }

  SpUtil._();

  Future init() async {
    await _lock.synchronized(
      () async {
        _prefs = await SharedPreferences.getInstance();
      },
    );
  }

  /// put object.
  static Future<bool> putObject(String key, Object value) async {
    if (_prefs == null) return false;
    return _prefs!.setString(key, json.encode(value));
  }

  /// get obj.
  static T getObj<T>(String key, T Function(Map v) f, {required T defValue}) {
    Map map = getObject(key);
    return f(map);
  }

  /// get object.
  static Map getObject(String key) {
    if (_prefs == null) return {"": ""};
    String? data = _prefs!.getString(key);
    return (data == null || data.isEmpty) ? {} : json.decode(data);
  }

  /// put object list.
  static Future<bool> putObjectList(String key, List<Object>? list) async {
    if (_prefs == null) return false;
    List<String>? dataList = list?.map((value) {
      return json.encode(value);
    }).toList();
    return _prefs!.setStringList(key, dataList ?? []);
  }

  /// get obj list.
  static List<T> getObjList<T>(String key, T Function(Map v) f,
      {List<T> defValue = const []}) {
    List<Map>? dataList = getObjectList(key);
    List<T>? list = dataList?.map((value) {
      return f(value);
    }).toList();
    return list ?? defValue;
  }

  /// get object list.
  static List<Map>? getObjectList(String key) {
    if (_prefs == null) return null;
    List<String>? dataLis = _prefs!.getStringList(key);
    return dataLis?.map((value) {
      Map dataMap = json.decode(value);
      return dataMap;
    }).toList();
  }

  /// get string.
  static String getString(String key, {String defValue = ''}) {
    if (_prefs == null) return defValue;
    return _prefs!.getString(key) ?? defValue;
  }

  /// put string.
  static Future<bool>? putString(String key, String value) {
    if (_prefs == null) return null;
    return _prefs!.setString(key, value);
  }

  /// get bool.
  static bool? getBool(String key, {bool defValue = false}) {
    if (_prefs == null) return defValue;
    return _prefs!.getBool(key) ?? defValue;
  }

  /// put bool.
  static Future<bool> putBool(String key, bool value) async {
    if (_prefs == null) return false;
    return _prefs!.setBool(key, value);
  }

  /// get int.
  static int getInt(String key, {int defValue = -1}) {
    if (_prefs == null) return defValue;
    return _prefs!.getInt(key) ?? defValue;
  }

  /// put int.
  static Future<bool> putInt(String key, int value) async {
    if (_prefs == null) return false;
    return _prefs!.setInt(key, value);
  }

  /// get double.
  static double getDouble(String key, {double defValue = 0.0}) {
    if (_prefs == null) return defValue;
    return _prefs!.getDouble(key) ?? defValue;
  }

  /// put double.
  static Future<bool> putDouble(String key, double value) async {
    if (_prefs == null) return false;
    return _prefs!.setDouble(key, value);
  }

  /// get string list.
  static List<String> getStringList(String key,
      {List<String> defValue = const []}) {
    if (_prefs == null) return defValue;
    return _prefs!.getStringList(key) ?? defValue;
  }

  /// put string list.
  static Future<bool> putStringList(String key, List<String> value) async {
    if (_prefs == null) return false;
    return _prefs!.setStringList(key, value);
  }

  /// get dynamic.
  static dynamic getDynamic(String key, {required Object defValue}) {
    if (_prefs == null) return defValue;
    return _prefs!.get(key) ?? defValue;
  }

  /// have key.
  static bool haveKey(String key) {
    if (_prefs == null) return false;
    return _prefs!.getKeys().contains(key);
  }

  /// get keys.
  static Set<String> getKeys() {
    if (_prefs == null) return Set<String>.identity();
    return _prefs!.getKeys();
  }

  /// remove.
  static Future<bool> remove(String key) async {
    if (_prefs == null) return false;
    return _prefs!.remove(key);
  }

  /// clear.
  static Future<bool> clear() async {
    //if (_prefs == null) return false;
    return _prefs!.clear();
  }

  ///Sp is initialized.
  static bool isInitialized() {
    return _prefs != null;
  }
}
