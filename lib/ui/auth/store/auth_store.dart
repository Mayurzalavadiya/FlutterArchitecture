import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:my_first_app/data/model/response/login_response.dart';
import '../../../core/api/base_response/base_response.dart';
import '../../../core/db/app_db.dart';
import '../../../core/exceptions/app_exceptions.dart';
import '../../../core/exceptions/dio_exception_util.dart';
import '../../../core/locator/locator.dart';
import '../../../data/model/request/login_request_model.dart';
import '../../../data/model/response/user_profile_response.dart';
import '../../../data/repository_impl/auth_repo_impl.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  @observable
  BaseResponse<UserData?>? loginResponse;

  @observable
  BaseResponse? logoutResponse;

  @observable
  BaseResponse<LoginResponse?>? users;

  @observable
  String? errorMessage;

  @observable
  bool isLoading = false;

  _AuthStoreBase();

  @action
  Future login(LoginRequestModel request) async {
    try {
      isLoading = true;
      errorMessage = null;
      // var commonStoreFuture =
      //     ObservableFuture<BaseResponse<UserData?>>(authRepo.signIn(request));
      // loginResponse = await commonStoreFuture;
      await Future.delayed(const Duration(seconds: 5), () {});
      loginResponse = BaseResponse(message: "Login successfully", code: "1");
    } on DioException catch (dioError) {
      errorMessage = DioExceptionUtil.handleError(dioError);
    } on AppException catch (e) {
      errorMessage = e.toString();
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future getUser(LoginRequestModel request) async {
    try {
      isLoading = true;
      errorMessage = null;
      var commonStoreFuture = ObservableFuture<BaseResponse<LoginResponse?>>(
        authRepo.getUser(),
      );
      users = await commonStoreFuture;
      signIn(request);
      // await Future.delayed(const Duration(seconds: 5), () {});
      // users = BaseResponse(message: "Login successfully", code: "1");
    } on DioException catch (dioError) {
      errorMessage = DioExceptionUtil.handleError(dioError);
    } on AppException catch (e) {
      errorMessage = e.toString();
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }


  Future<void> signIn(LoginRequestModel response) async {
    try {
      /*final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: response.email,
        password: response.password,
      );
      debugPrint("✅ Logged in as ${userCredential.user?.email}");
    } on FirebaseAuthException catch (e) {
      debugPrint("⚠️ FirebaseAuthException: ${e.code}");

      if (e.code == 'user-not-found') {
        try {*/
          final newUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: response.email,
            password: response.password,
          );
          debugPrint("🆕 Firebase user created: ${newUser.user?.email}");
        } on FirebaseAuthException catch (createError) {
          debugPrint("❌ Firebase create error: ${createError.code} - ${createError.message}");
        }
      // }
      /*else {
        debugPrint("❌ Firebase login error: ${e.code} - ${e.message}");
      }
    } */

    catch (e, st) {
      debugPrint("❌ Unexpected error: $e");
      debugPrintStack(stackTrace: st);
    }
  }


  @action
  Future logout() async {
    try {
      errorMessage = null;
      var commonStoreFuture = ObservableFuture<BaseResponse>(authRepo.logout());
      logoutResponse = await commonStoreFuture;
    } on DioException catch (dioError) {
      errorMessage = DioExceptionUtil.handleError(dioError);
    } on AppException catch (e) {
      errorMessage = e.toString();
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: st);
      errorMessage = e.toString();
    }
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    debugPrint("JsonDecode:--------------------");
    debugPrint(payload);
    debugPrint(jsonEncode(payloadMap));

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}

final authStore = locator<AuthStore>();
final storage = new FlutterSecureStorage();
