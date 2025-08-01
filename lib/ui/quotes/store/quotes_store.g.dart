// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuotesStore on _QuotesStoreBase, Store {
  Computed<List<Quotes>>? _$filteredQuotesComputed;

  @override
  List<Quotes> get filteredQuotes => (_$filteredQuotesComputed ??=
          Computed<List<Quotes>>(() => super.filteredQuotes,
              name: '_QuotesStoreBase.filteredQuotes'))
      .value;

  late final _$getQuotesResponseAtom =
      Atom(name: '_QuotesStoreBase.getQuotesResponse', context: context);

  @override
  GetQuotesResponse? get getQuotesResponse {
    _$getQuotesResponseAtom.reportRead();
    return super.getQuotesResponse;
  }

  @override
  set getQuotesResponse(GetQuotesResponse? value) {
    _$getQuotesResponseAtom.reportWrite(value, super.getQuotesResponse, () {
      super.getQuotesResponse = value;
    });
  }

  late final _$quotesListAtom =
      Atom(name: '_QuotesStoreBase.quotesList', context: context);

  @override
  ObservableList<Quotes> get quotesList {
    _$quotesListAtom.reportRead();
    return super.quotesList;
  }

  @override
  set quotesList(ObservableList<Quotes> value) {
    _$quotesListAtom.reportWrite(value, super.quotesList, () {
      super.quotesList = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_QuotesStoreBase.errorMessage', context: context);

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

  late final _$isLoadingAtom =
      Atom(name: '_QuotesStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$hasLoadedOnceAtom =
      Atom(name: '_QuotesStoreBase.hasLoadedOnce', context: context);

  @override
  bool get hasLoadedOnce {
    _$hasLoadedOnceAtom.reportRead();
    return super.hasLoadedOnce;
  }

  @override
  set hasLoadedOnce(bool value) {
    _$hasLoadedOnceAtom.reportWrite(value, super.hasLoadedOnce, () {
      super.hasLoadedOnce = value;
    });
  }

  late final _$skipAtom = Atom(name: '_QuotesStoreBase.skip', context: context);

  @override
  int get skip {
    _$skipAtom.reportRead();
    return super.skip;
  }

  @override
  set skip(int value) {
    _$skipAtom.reportWrite(value, super.skip, () {
      super.skip = value;
    });
  }

  late final _$limitAtom =
      Atom(name: '_QuotesStoreBase.limit', context: context);

  @override
  int get limit {
    _$limitAtom.reportRead();
    return super.limit;
  }

  @override
  set limit(int value) {
    _$limitAtom.reportWrite(value, super.limit, () {
      super.limit = value;
    });
  }

  late final _$searchQueryAtom =
      Atom(name: '_QuotesStoreBase.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$getQuotesDataAsyncAction =
      AsyncAction('_QuotesStoreBase.getQuotesData', context: context);

  @override
  Future<dynamic> getQuotesData(int limit, int skip) {
    return _$getQuotesDataAsyncAction
        .run(() => super.getQuotesData(limit, skip));
  }

  late final _$addQuoteAsyncAction =
      AsyncAction('_QuotesStoreBase.addQuote', context: context);

  @override
  Future<void> addQuote(Quotes quote) {
    return _$addQuoteAsyncAction.run(() => super.addQuote(quote));
  }

  late final _$updateQuoteAsyncAction =
      AsyncAction('_QuotesStoreBase.updateQuote', context: context);

  @override
  Future<void> updateQuote(Quotes quote) {
    return _$updateQuoteAsyncAction.run(() => super.updateQuote(quote));
  }

  late final _$deleteQuoteAsyncAction =
      AsyncAction('_QuotesStoreBase.deleteQuote', context: context);

  @override
  Future<void> deleteQuote(int? quoteId) {
    return _$deleteQuoteAsyncAction.run(() => super.deleteQuote(quoteId));
  }

  late final _$clearQuotesAsyncAction =
      AsyncAction('_QuotesStoreBase.clearQuotes', context: context);

  @override
  Future<void> clearQuotes() {
    return _$clearQuotesAsyncAction.run(() => super.clearQuotes());
  }

  late final _$loadQuotesFromCacheAsyncAction =
      AsyncAction('_QuotesStoreBase.loadQuotesFromCache', context: context);

  @override
  Future<void> loadQuotesFromCache() {
    return _$loadQuotesFromCacheAsyncAction
        .run(() => super.loadQuotesFromCache());
  }

  late final _$_QuotesStoreBaseActionController =
      ActionController(name: '_QuotesStoreBase', context: context);

  @override
  void increment() {
    final _$actionInfo = _$_QuotesStoreBaseActionController.startAction(
        name: '_QuotesStoreBase.increment');
    try {
      return super.increment();
    } finally {
      _$_QuotesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFavourite(Quotes quote) {
    final _$actionInfo = _$_QuotesStoreBaseActionController.startAction(
        name: '_QuotesStoreBase.setFavourite');
    try {
      return super.setFavourite(quote);
    } finally {
      _$_QuotesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchQuery(String value) {
    final _$actionInfo = _$_QuotesStoreBaseActionController.startAction(
        name: '_QuotesStoreBase.setSearchQuery');
    try {
      return super.setSearchQuery(value);
    } finally {
      _$_QuotesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
getQuotesResponse: ${getQuotesResponse},
quotesList: ${quotesList},
errorMessage: ${errorMessage},
isLoading: ${isLoading},
hasLoadedOnce: ${hasLoadedOnce},
skip: ${skip},
limit: ${limit},
searchQuery: ${searchQuery},
filteredQuotes: ${filteredQuotes}
    ''';
  }
}
