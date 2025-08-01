import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {

  void logScreenView(String screenName) {
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'LoginScreen',
      screenClass: 'LoginScreen',
    );
  }

}
