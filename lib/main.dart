
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_first_app/router/app_router.dart';
import 'package:my_first_app/ui/provider/provider/todo_provider.dart';
import 'package:my_first_app/utils/notification_service.dart';
import 'package:my_first_app/widget/show_message.dart';
import 'package:provider/provider.dart';

import 'core/db/app_db.dart';
import 'core/db/share_pref.dart';
import 'core/locator/locator.dart';
import 'generated/l10n.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("🔕 Background Message: \${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // Initialize Firebase
  await Firebase.initializeApp();

  // Crashlytics Setup
  // Enable Crashlytics
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // Pass uncaught errors to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.log("$error");
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };


  // ✅ Initialize FCM + Local Notifications
  await NotificationService.initializeFCM();
  await NotificationService.printFCMToken();

  // ✅ Handle app launch via notification (terminated)
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  Map<String, dynamic>? notificationData;
  if (initialMessage != null) {
    debugPrint("🚀 App launched via push: \${initialMessage.data}");
    notificationData = initialMessage.data;
  }

  // ✅ Background handler
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //messaging
  // final messaging = FirebaseMessaging.instance;
  // await messaging.requestPermission();
  // final token = await messaging.getToken();
  // debugPrint("📱 FCM Token: $token");

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // ✅ Foreground message
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    showMessage("📩 ${message.notification?.title ?? 'New Message'}");
  });

  // ✅ Background handler


  if (kReleaseMode) {
    print('Running in Release Mode!');
  }

  await setupLocator();
  await locator.isReady<AppDB>();
  await locator.isReady<AppPreferences>();
  await NotificationService.initializeFCM();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TodoProvider())],
      child: MyApp(appRouter: locator<AppRouter>()),
    ),
  );
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final AppRouter appRouter;

  MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, __) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // theme: appTheme,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,

        /* home: const WebViewPage(
          title: 'Flutter Demo Home Page',
          url: 'https://unsplash.com/',
        ),*/
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        // home: const SplashPage(),
        routerConfig: appRouter.config(
          navigatorObservers: () => [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
        ),

        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }

}
