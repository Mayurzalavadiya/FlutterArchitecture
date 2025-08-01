import 'package:my_first_app/data/model/response/get_quotes_response.dart';
import 'package:my_first_app/data/model/response/get_todos_response.dart';
import 'package:my_first_app/data/model/response/login_response.dart';

import '../../core/api/base_response/base_response.dart';
import '../../core/locator/locator.dart';
import '../model/request/login_request_model.dart';
import '../model/response/get_cart_data.dart';
import '../model/response/user_profile_response.dart';
import '../remote/auth_api.dart';
import '../repository/auth_repo.dart';

class AuthRepoImpl extends AuthRepository {
  AuthApi authApi;

  AuthRepoImpl({required this.authApi});

  @override
  Future<BaseResponse<UserData?>> signIn(LoginRequestModel request) async {
    final BaseResponse<UserData?> response = await authApi.signIn(request);
    return response;
  }

  @override
  Future<BaseResponse> logout() async {
    final BaseResponse response = await authApi.logout();
    return response;
  }

  @override
  Future<BaseResponse<LoginResponse?>> getUser() async {
    return await authApi.getUser();
  }

  @override
  Future<BaseResponse<GetCartData?>> getCartData() async {
    return await authApi.getCartData();
  }

  @override
  Future<GetQuotesResponse?> getQuotesData(int limit, int skip) async {
    return await authApi.getQuotesData(limit, skip);
  }

  @override
  Future<GetTodosResponse?> getTodosData() async {
    return await authApi.getTodosData();
  }

}

final authRepo = locator<AuthRepoImpl>();
