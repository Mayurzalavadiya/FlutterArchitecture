import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TweenAnimationPage extends StatefulWidget {
  const TweenAnimationPage({super.key});


  @override
  State<TweenAnimationPage> createState() => _TweenAnimationPageState();
}

class _TweenAnimationPageState extends State<TweenAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('TweenAnimationBuilder')),
        body: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(seconds: 10),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.scale(
                  scale: value,
                  child: child,
                ),
              );
            },
            child: Container(
              width: 100,
              height: 100,
              color: Colors.purple,
              child: Center(child: Text('Tween')),
            ),
          ),
        ),
      ),
    );
  }
}
