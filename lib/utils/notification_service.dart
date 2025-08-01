import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initializeFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // iOS + Android 13+ permission request
    // NotificationSettings settings = await messaging.requestPermission();

    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   debugPrint("✅ Push Notification Permission Granted");
    // } else {
    //   debugPrint("❌ Push Notification Permission Denied");
    // }

    // Initialize local notifications
    await _initializeLocalNotifications();

    // Foreground push
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("📩 FCM Foreground Message: ${message.notification?.title}");
      showLocalNotification(message);
      handleNotificationNavigation(message.data);
    });

    // Background push tap
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("🚪 Notification tapped (background): ${message.data}");
      showLocalNotification(message);
      handleNotificationNavigation(message.data);
    });
  }

  static void handleNotificationNavigation(Map<String, dynamic> data) {
    debugPrint("🚪 Notification tapped (background): $data");
    final screen = data['screen'];
    final offerId = data['offerId'];

    // Push routes using router or navigatorKey
    if (screen == 'offer_page' && offerId != null) {
      navigatorKey.currentState?.pushNamed('/offer', arguments: offerId);
    } else if (screen == 'profile') {
      navigatorKey.currentState?.pushNamed('/profile');
    } else {
      navigatorKey.currentState?.pushNamed('/home');
    }
  }


  static Future<String?> printFCMToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint("📱 FCM Token: $token");
    return token;
  }

  // 🔽 Initialize local notification plugin
  static Future<void> _initializeLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOSInit = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iOSInit,
    );

    await _localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint("🔔 Notification tapped (local): ${response.payload}");
        // TODO: Handle tap logic here
      },
    );
  }

  // 🔽 Show a local notification from FCM message
  static Future<void> showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Notifications',
      channelDescription: 'This channel is used for default notifications.',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const platformDetails = NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? 'No Title',
      message.notification?.body ?? 'No Body',
      platformDetails,
      payload: message.data.toString(),
    );
  }
}

