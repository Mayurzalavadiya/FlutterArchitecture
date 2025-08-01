import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/ui/provider/provider/todo_provider.dart';
import 'package:my_first_app/values/colors.dart';
import 'package:my_first_app/widget/base_app_bar.dart';
import 'package:my_first_app/widget/loading_widget.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProviderPage extends StatefulWidget {
  const ProviderPage({super.key});

  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {

  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();

    // Trigger API on page load
    Future.microtask(() {
      final todoProvider = Provider.of<TodoProvider>(context, listen: false);
      todoProvider.getTodosData(50, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: BaseAppBar(
        title: 'Todos',
        leadingIcon: true,
        showTitle: true,
        centerTitle: false,
        statusBarColor: AppColor.white,
        titleWidgetColor: AppColor.white,
      ),
      body: Builder(
        builder: (_) {
          if (todoProvider.errorMessage != null &&
              todoProvider.todosList.isEmpty) {
            return Center(child: Text(todoProvider.errorMessage!));
          }

          return LoadingWidget(
            status: todoProvider.isLoading,
            child: RefreshIndicator(
              onRefresh: () async {
                await todoProvider.getTodosData(5, 0);
              },
              child: ListView.separated(
                itemCount: todoProvider.todosList.length,
                itemBuilder: (context, index) {
                  final todo = todoProvider.todosList[index];
                  return ListTile(
                    title: Text(todo.todo ?? "No title"),
                    subtitle: Text("Completed: ${todo.completed}"),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          );
        },
      ),
    );
  }
}
