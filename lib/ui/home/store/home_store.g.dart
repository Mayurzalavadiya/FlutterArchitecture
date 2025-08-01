// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStoreBase, Store {
  late final _$cartResponseAtom =
      Atom(name: '_HomeStoreBase.cartResponse', context: context);

  @override
  BaseResponse<GetCartData?>? get cartResponse {
    _$cartResponseAtom.reportRead();
    return super.cartResponse;
  }

  @override
  set cartResponse(BaseResponse<GetCartData?>? value) {
    _$cartResponseAtom.reportWrite(value, super.cartResponse, () {
      super.cartResponse = value;
    });
  }

  late final _$cartsListAtom =
      Atom(name: '_HomeStoreBase.cartsList', context: context);

  @override
  ObservableList<Carts> get cartsList {
    _$cartsListAtom.reportRead();
    return super.cartsList;
  }

  @override
  set cartsList(ObservableList<Carts> value) {
    _$cartsListAtom.reportWrite(value, super.cartsList, () {
      super.cartsList = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_HomeStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$getCartDataAsyncAction =
      AsyncAction('_HomeStoreBase.getCartData', context: context);

  @override
  Future<dynamic> getCartData() {
    return _$getCartDataAsyncAction.run(() => super.getCartData());
  }

  late final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase', context: context);

  @override
  void removeProductFromCart(int cartIndex, int productIndex) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.removeProductFromCart');
    try {
      return super.removeProductFromCart(cartIndex, productIndex);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelected(int cartIndex, int productIndex) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.setSelected');
    try {
      return super.setSelected(cartIndex, productIndex);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cartResponse: ${cartResponse},
cartsList: ${cartsList},
errorMessage: ${errorMessage}
    ''';
  }
}
