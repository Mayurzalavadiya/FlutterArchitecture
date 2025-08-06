import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_first_app/router/app_router.dart';
import 'package:my_first_app/values/export.dart';

import '../../../../core/locator/locator.dart';
import '../../../../generated/assets.dart';
import '../../../../widget/base_app_bar.dart';

@RoutePage()
class FigmaSplashPage extends StatefulWidget {
  const FigmaSplashPage({super.key});

  @override
  State<FigmaSplashPage> createState() => _FigmaSplashPageState();
}

class _FigmaSplashPageState extends State<FigmaSplashPage> {
  @override
  void initState() {
    super.initState();
    setStatusBarColor(color: AppColor.transparent);
    initSetting();
  }

  Future<void> initSetting() async {
    Future.delayed(const Duration(seconds: 3), () {
      context.replaceRoute(FigmaLoginRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Assets.imageFigmaImageSplash, width: double.infinity, fit: BoxFit.cover),
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: Image.asset(Assets.imageFigmaLoader, height: 76.h, width: 213.w),
        ),

        Positioned(
          bottom: 72,
          right: 0,
          left: 0,
          child: Image.asset(
            Assets.imageFigmaFlutterLogo,
            height: 32.h,
            width: 111.w,
          ),
        ),
      ],
    );
  }
}
