import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../data/model/generalData/user_model.dart';

@RoutePage()
class DetailPage extends StatefulWidget {
  final UserModel user;

  const DetailPage({super.key, required this.user});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late UserModel _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0; // Slow motion for demo

    return Scaffold(
      appBar: AppBar(title: Text("User Detail")),
      body: Column(
        children: [
          Hero(
            tag: 'user-${_user.id}',
            child: Material(
              type: MaterialType.transparency,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(_user.imageUrl),
                ),
                title: Text(_user.name, style: const TextStyle(fontSize: 22)),
                subtitle: Text(_user.email, style: const TextStyle(fontSize: 16)),
                tileColor: Colors.blue[100],
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),

        ],


      ),
    );
  }
}
