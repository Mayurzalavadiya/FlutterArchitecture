import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:my_first_app/data/model/response/get_cart_data.dart';

import '../../../core/api/base_response/base_response.dart';
import '../../../core/exceptions/app_exceptions.dart';
import '../../../core/exceptions/dio_exception_util.dart';
import '../../../core/locator/locator.dart';
import '../../../data/repository_impl/auth_repo_impl.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  @observable
  BaseResponse<GetCartData?>? cartResponse;

 @observable
 ObservableList<Carts> cartsList = ObservableList<Carts>();

  @observable
  String? errorMessage;

  _HomeStoreBase();

  @action
  void removeProductFromCart(int cartIndex, int productIndex) {
    cartResponse?.data!.carts?[cartIndex].products?.removeAt(productIndex);
  }

  @action
  void setSelected(int cartIndex, int productIndex) {
    final product = cartsList[cartIndex].products?[productIndex];
    if (product != null) {
      product.isSelected = !(product.isSelected ?? false);
      cartsList = ObservableList.of([...cartsList]); // Trigger MobX reaction
    }
  }

  @action
  Future getCartData() async {
    try {
      errorMessage = null;
      final response = await authRepo.getCartData();
      cartResponse = response;

      if (response.data?.carts != null) {
        cartsList.clear();
        cartsList.addAll(response.data?.carts! as Iterable<Carts>);
      } else {
        errorMessage = "No More Data";
      }
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
}

final homeStore = locator<HomeStore>();
final storage = new FlutterSecureStorage();
