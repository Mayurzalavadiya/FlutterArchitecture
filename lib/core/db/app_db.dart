import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';
import 'package:my_first_app/data/model/response/get_cart_data.dart';
import 'package:my_first_app/data/model/response/login_response.dart';

import '../../data/model/response/get_quotes_response.dart';
import '../locator/locator.dart';

class AppDB {
  static const _appDbBox = '_appDbBox';
  static const fcmKey = 'fcm_key';
  static const platform = 'platform';
  static const isLoginKey = 'isLogin';
  static const tokenKey = 'token';
  static const cartCountKey = 'cart_count';
  static const apiKeyKey = 'apiKey';
  static const userKey = 'user';
  static const firstTimeKey = 'firstTime';
  static const cachedQuotesKey = 'cached_quotes';
  static const hiveKey = 'hive_data';

  final Box<dynamic> _box;

  AppDB._(this._box);

  static Future<AppDB> getInstance() async {
    final box = await Hive.openBox<dynamic>(_appDbBox);
    return AppDB._(box);
  }

  T getValue<T>(String key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> setValue<T>(String key, T value) => _box.put(key, value);

  Future<void> clearSessionKeys(List<String> keys) async {
    for (final key in keys) {
      await _box.delete(key);
    }
  }

  Future<void> clearSession() async {
    await _box.clear(); // replace with actual box name
  }

  bool get firstTime => getValue(firstTimeKey, defaultValue: false);

  set firstTime(bool update) => setValue(firstTimeKey, update);

  bool get isLogin => getValue(isLoginKey, defaultValue: false);

  set isLogin(bool update) => setValue(isLoginKey, update);

  String get token => getValue(tokenKey, defaultValue: "");

  set token(String update) => setValue(tokenKey, update);

  String get fcmToken => getValue(fcmKey, defaultValue: "0");

  set fcmToken(String update) => setValue(fcmKey, update);

  int get cartCount => getValue(cartCountKey, defaultValue: 0);

  set cartCount(int update) => setValue(cartCountKey, update);

  String get apiKey => getValue(apiKeyKey, defaultValue: "");

  set apiKey(String update) => setValue(apiKeyKey, update);

  LoginResponse get user => getValue(userKey);

  set user(LoginResponse user) => setValue(userKey, user);

  List<Products> get products =>
      List<Products>.from(getValue(hiveKey, defaultValue: <Products>[]));

  set products(List<Products> products) => setValue(hiveKey, products);

  List<Quotes> get cachedQuotes =>
      List<Quotes>.from(getValue(cachedQuotesKey, defaultValue: <Quotes>[]));

  set cachedQuotes(List<Quotes> list) => setValue(cachedQuotesKey, list);

  // CREATE or UPDATE single
  Future<void> saveQuote(Quotes quote) async {
    final list = cachedQuotes;
    final index = list.indexWhere((q) => q.id == quote.id);
    if (index != -1) {
      list[index] = quote;
    } else {
      list.add(quote);
    }
    cachedQuotes = list;
  }

  // DELETE
  Future<void> deleteQuote(int? quoteId) async {
    final list = cachedQuotes..removeWhere((q) => q.id == quoteId);
    cachedQuotes = list;
  }

  // CLEAR ALL
  Future<void> clearQuotes() async {
    await _box.delete(cachedQuotesKey);
  }

  void logout() {
    clearSession();
    // token = "";
    // isLogin = false;
    // firstTime = true;
  }
}

final appDB = locator<AppDB>();
