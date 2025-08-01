import 'package:dio/dio.dart';
import 'package:my_first_app/core/api/api_end_points.dart';
import 'package:my_first_app/data/model/response/get_cart_data.dart';
import 'package:my_first_app/data/model/response/get_todos_response.dart';
import 'package:my_first_app/data/model/response/login_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../core/api/base_response/base_response.dart';
import '../model/request/login_request_model.dart';
import '../model/response/get_quotes_response.dart';
import '../model/response/user_profile_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST(APIEndPoints.login)
  Future<BaseResponse<UserData?>> signIn(@Body() LoginRequestModel request);

  @POST('/user_authentication/logout')
  Future<BaseResponse> logout();

  @GET(APIEndPoints.getUser)
  Future<BaseResponse<LoginResponse?>> getUser();

  @GET(APIEndPoints.getCartData)
  Future<BaseResponse<GetCartData?>> getCartData();

  @GET(APIEndPoints.getQuotes)
  Future<GetQuotesResponse?> getQuotesData(
    @Query("limit") int limit,
    @Query("skip") int skip,
  );

  @GET(APIEndPoints.getTodos)
  Future<GetTodosResponse?> getTodosData();
}
