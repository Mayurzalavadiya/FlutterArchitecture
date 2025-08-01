import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/core/db/share_pref.dart';
import 'package:my_first_app/router/app_router.dart';
import 'package:my_first_app/values/colors.dart';

import '../../core/db/app_db.dart';
import '../../core/locator/locator.dart';
import '../../utils/notification_service.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _setup();
    super.initState();
  }

  Future<void> _setup() async {
    // ✅ Initialize FCM and permissions
    await NotificationService.initializeFCM();

    // ✅ Get FCM token and save
    String? fcmToken = await NotificationService.printFCMToken();
    debugPrint(" ✅ Get FCM token splash $fcmToken");
    appDB.fcmToken = fcmToken!;
    // ✅ Continue with splash setup
    initSetting();
  }

  Future<void> initSetting() async {
    Future.delayed(const Duration(seconds: 2), () {
      final appDB = locator.get<AppDB>();
      if (!appPreferences.isLogin) {
        /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );*/
        context.router.replaceAll([LoginRoute()]);

      } else {
        
        context.router.replaceAll([BottomNavRoute()]);
        /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BottomNavPage()),
        );*/
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.teal,
      child: const Center(
        child: FlutterLogo(
          size: 50,
        ),
      ),
    );
  }
}
