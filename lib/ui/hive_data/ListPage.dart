import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import '../../data/model/generalData/user_model.dart';
import '../../router/app_router.dart';
import '../../values/style.dart';

@RoutePage()
class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final List<UserModel> users = List.generate(
    10,
    (i) => UserModel(
      id: '$i',
      name: 'User $i',
      email: 'user$i@example.com',
      imageUrl: 'https://i.pravatar.cc/150?img=$i',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hero List")),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return GestureDetector(
            onTap: () {
              context.pushRoute(DetailRoute(user: user));
            },
            child: Hero(
              tag: 'user-${user.id}',
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  decoration: boxDecoration.copyWith(
                    color: Colors.teal.withOpacity(0.5),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.imageUrl),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
