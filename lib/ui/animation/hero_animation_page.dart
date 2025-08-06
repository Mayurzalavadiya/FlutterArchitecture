import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../router/app_router.dart';

@RoutePage()
class HeroAnimationPage extends StatefulWidget {
  const HeroAnimationPage({super.key});

  @override
  State<HeroAnimationPage> createState() => _HeroAnimationPageState();
}

class _HeroAnimationPageState extends State<HeroAnimationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hero Animation - Page 1")),
      body: Center(
        child: GestureDetector(
          onTap: () {
            context.router.push(SecondRoute());
          },
          child: Hero(
            tag: 'hero-demo',
            child: Container(
              width: 100,
              height: 100,
              color: Colors.orange,
              child: Center(child: Text('Next',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@RoutePage()
class SecondPage extends StatelessWidget {

  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hero Animation - Page 2")),
      body: GestureDetector(
        onTap: () {
          context.back();
        },
        child: Hero(
          tag: 'hero-demo',
          child: Container(
            width: 300,
            height: 300,
            color: Colors.lightBlue,
            child: Center(child: Text('Back',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),),
            ),
          ),
        ),
      ),
    );
  }
}