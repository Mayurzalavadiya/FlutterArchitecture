import 'package:my_first_app/data/model/response/get_todos_response.dart';

import '../../core/api/base_response/base_response.dart';
import '../model/request/login_request_model.dart';
import '../model/response/get_cart_data.dart';
import '../model/response/get_quotes_response.dart';
import '../model/response/login_response.dart';
import '../model/response/user_profile_response.dart';

abstract class AuthRepository {
  Future<BaseResponse<UserData?>> signIn(LoginRequestModel request);

  Future<BaseResponse<LoginResponse?>> getUser();

  Future<BaseResponse<GetCartData?>> getCartData();

  Future<BaseResponse> logout();

  Future<GetQuotesResponse?> getQuotesData(int limit, int skip);

  Future<GetTodosResponse?> getTodosData();
}
