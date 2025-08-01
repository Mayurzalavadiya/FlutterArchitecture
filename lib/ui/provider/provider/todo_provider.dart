import 'package:flutter/cupertino.dart';

import '../../../data/model/response/get_todos_response.dart';
import '../../../data/repository_impl/auth_repo_impl.dart';

class TodoProvider with ChangeNotifier {
  GetTodosResponse? getTodosResponse;

  final List<Todos> _todosList = [];

  List<Todos> get todosList => _todosList; // <-- add getter

  String? errorMessage;

  bool isLoading = false;
  bool hasLoadedOnce = false;

  int skip = 0;
  int limit = 50;

  void increment() {
    skip = skip + limit;
    getTodosData(limit, skip);
  }

  Future getTodosData(int limit, int skip) async {
    // if (hasLoadedOnce && skip == 0) return;

    try {
      // if (skip == 0) isLoading = true;
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final response = await authRepo.getTodosData();
      getTodosResponse = response;

      if (response != null && response.todos != null) {
        if (skip == 0) _todosList.clear(); // refresh only on first page
        _todosList.addAll(response.todos!);
        // hasLoadedOnce = true;
      } else {
        errorMessage = "No More Data";
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
