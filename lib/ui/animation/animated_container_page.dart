import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AnimatedContainerPage extends StatefulWidget {
  const AnimatedContainerPage({super.key});

  @override
  State<AnimatedContainerPage> createState() =>
      _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {
  double _width = 100;
  double _height = 100;
  Color _color = Colors.blue;

  void _changeProperties() {
    setState(() {
      _width = _width == 100 ? 200 : 100;
      _height = _height == 100 ? 500 : 100;
      _color = _color == Colors.blue ? Colors.red : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('AnimatedContainer')),
        body: Center(
          child: AnimatedContainer(
            width: _width,
            height: _height,
            color: _color,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            child: Center(child: Text('Tap FAB')),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _changeProperties,
          child: Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
