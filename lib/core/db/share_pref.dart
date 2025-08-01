import 'dart:convert';

import 'package:my_first_app/data/model/response/user_profile_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/data/model/response/get_cart_data.dart';
import 'package:my_first_app/data/model/response/login_response.dart';

import '../locator/locator.dart';

class AppPreferences {
  static const fcmKey = 'fcm_key';
  static const platform = 'platform';
  static const isLoginKey = 'isLogin';
  static const tokenKey = 'token';
  static const cartCountKey = 'cart_count';
  static const apiKeyKey = 'apiKey';
  static const userKey = 'user';
  static const productsKey = 'products';
  static const firstTimeKey = 'firstTime';
  static const cachedQuotesKey = 'cached_quotes';
  static const cachedCartKey = 'cached_cart';
  static const hiveKey = 'hive_data';


  static SharedPreferences? _prefs;

  static Future<AppPreferences> getInstance() async {
    _prefs ??= await SharedPreferences.getInstance();
    return AppPreferences();
  }

  T getValue<T>(String key, {T? defaultValue}) {
    final value = _prefs!.get(key);
    if (value is T) return value;
    return defaultValue!;
  }

  Future<void> setValue<T>(String key, T value) async {
    if (value is String) {
      await _prefs!.setString(key, value);
    } else if (value is bool) {
      await _prefs!.setBool(key, value);
    } else if (value is int) {
      await _prefs!.setInt(key, value);
    } else if (value is double) {
      await _prefs!.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs!.setStringList(key, value);
    } else {
      throw UnsupportedError("Unsupported type");
    }
  }

  Future<void> clearSessionKeys(List<String> keys) async {
    for (final key in keys) {
      await _prefs!.remove(key);
    }
  }


  Future<void> clearSession() async {
    await _prefs!.clear();
  }

  bool get firstTime => getValue(firstTimeKey, defaultValue: false);
  set firstTime(bool value) => setValue(firstTimeKey, value);

  bool get isLogin => getValue(isLoginKey, defaultValue: false);
  set isLogin(bool value) => setValue(isLoginKey, value);

  String get token => getValue(tokenKey, defaultValue: "");
  set token(String value) => setValue(tokenKey, value);

  String get fcmToken => getValue(fcmKey, defaultValue: "0");
  set fcmToken(String value) => setValue(fcmKey, value);

  int get cartCount => getValue(cartCountKey, defaultValue: 0);
  set cartCount(int value) => setValue(cartCountKey, value);

  String get apiKey => getValue(apiKeyKey, defaultValue: "");
  set apiKey(String value) => setValue(apiKeyKey, value);

  UserData? get user {
    final jsonString = _prefs!.getString(userKey);
    return jsonString == null ? null : UserData.fromJson(jsonDecode(jsonString));
  }

  set user(UserData? value) {
    if (value != null) {
      _prefs!.setString(userKey, jsonEncode(value.toJson()));
    }
  }

  List<Products> get products {
    final jsonString = _prefs!.getString(hiveKey);
    if (jsonString == null) return <Products>[];
    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => Products.fromJson(e)).toList();
  }

  set products(List<Products> value) {
    final encoded = jsonEncode(value.map((e) => e.toJson()).toList());
    _prefs!.setString(hiveKey, encoded);
  }

  void logout() {
    clearSession();
    // token = "";
    // isLogin = false;
    // firstTime = true;
    // _prefs!.remove("user");
    // _prefs!.remove("hive_data");
  }
}

final appPreferences = locator<AppPreferences>();
