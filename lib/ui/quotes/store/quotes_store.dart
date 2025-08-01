import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_first_app/core/db/app_db.dart';
import 'package:my_first_app/data/model/response/get_quotes_response.dart';

import '../../../core/api/base_response/base_response.dart';
import '../../../core/exceptions/app_exceptions.dart';
import '../../../core/exceptions/dio_exception_util.dart';
import '../../../core/locator/locator.dart';
import '../../../data/repository_impl/auth_repo_impl.dart';
import '../../../generated/l10n.dart';

part 'quotes_store.g.dart';

class QuotesStore = _QuotesStoreBase with _$QuotesStore;

abstract class _QuotesStoreBase with Store {
  @observable
  GetQuotesResponse? getQuotesResponse;

  @observable
  ObservableList<Quotes> quotesList = ObservableList<Quotes>();

  @observable
  String? errorMessage;

  @observable
  bool isLoading = false;

  @observable
  bool hasLoadedOnce = false;

  @observable
  int skip = 0;

  @observable
  int limit = 50;

  _QuotesStoreBase();

  @action
  void increment() {
    skip = skip + limit;
    getQuotesData(limit, skip);
  }

  @observable
  String searchQuery = "";

  @action
  void setFavourite(Quotes quote) {
    final index = quotesList.indexOf(quote);
    if (index != -1) {
      final updated = quote.copyWith(isFavourite: !quote.isFavourite);
      quotesList[index] = updated; // Triggers observer
    }
  }

  @action
  void setSearchQuery(String value) {
    searchQuery = value;
  }

  @computed
  List<Quotes> get filteredQuotes => quotesList
      .where(
        (q) =>
            q.author?.toLowerCase().contains(searchQuery.toLowerCase()) ??
            false,
      )
      .toList();

  @action
  Future getQuotesData(int limit, int skip) async {
    if (hasLoadedOnce && skip == 0) return;

    try {
      if (skip == 0) isLoading = true;

      errorMessage = null;

      final response = await authRepo.getQuotesData(limit, skip);
      getQuotesResponse = response;

      if (response != null && response.quotes != null) {
        if (skip == 0) quotesList.clear(); // refresh only on first page
        quotesList.addAll(response.quotes!);
        appDB.cachedQuotes = quotesList;
        appDB.setValue<int>("Quotes_totle", response.total);
        hasLoadedOnce = true;
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
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> addQuote(Quotes quote) async {
    quotesList.add(quote);
    await appDB.saveQuote(quote);
  }

  @action
  Future<void> updateQuote(Quotes quote) async {
    final index = quotesList.indexWhere((q) => q.id == quote.id);
    if (index != -1) {
      quotesList[index] = quote;
      await appDB.saveQuote(quote);
    }
  }

  @action
  Future<void> deleteQuote(int? quoteId) async {
    quotesList.removeWhere((q) => q.id == quoteId);
    await appDB.deleteQuote(quoteId);
  }

  @action
  Future<void> clearQuotes() async {
    quotesList.clear();
    skip=0;
    hasLoadedOnce = false;
    await appDB.clearQuotes();
  }

  @action
  Future<void> loadQuotesFromCache() async {
    try {
      isLoading = true;
      final cachedQuotes = appDB.cachedQuotes;

      if (cachedQuotes.isNotEmpty) {
        quotesList.clear();
        quotesList.addAll(cachedQuotes);
        skip = quotesList.length-limit;
        hasLoadedOnce = true;
      } else {
        errorMessage = S.current.noActiveInternetConnection;
      }
    } catch (e) {
      errorMessage = "Cache error: ${e.toString()}";
    } finally {
      isLoading = false;
    }
  }
}

final quotesStore = locator<QuotesStore>();
