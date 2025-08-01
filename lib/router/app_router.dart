import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../core/locator/locator.dart';
import '../ui/animation/animated_container_page.dart';
import '../ui/animation/hero_animation_page.dart';
import '../ui/animation/tween_animation_page.dart';
import '../ui/auth/login_page.dart';
import '../ui/editProfile/image_video_picker_page.dart';
import '../ui/hive_data/hive_data_page.dart';
import '../ui/home/home/home_page.dart';
import '../ui/provider/providerPage.dart';
import '../ui/quotes/quptes_page.dart';
import '../ui/splash/splash_page.dart';
import '../ui/widgets/bottom_nav.dart';
import '../ui/widgets/widgets_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends _$AppRouter {


  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, initial: true, path: '/splash'),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: HomeRoute.page, path: '/home'),
    AutoRoute(page: BottomNavRoute.page, path: '/bottomNav'),
    AutoRoute(page: QuotesRoute.page, path: '/quotes'),
    AutoRoute(page: ProviderRoute.page, path: '/provider'),
    AutoRoute(page: ImageVideoPickerRoute.page, path: '/imagePicker'),
    AutoRoute(page: AnimatedContainerRoute.page, path: '/animationContainer'),
    AutoRoute(page: TweenAnimationRoute.page, path: '/tweenAnimation'),
    AutoRoute(page: HeroAnimationRoute.page, path: '/heroAnimation'),
    AutoRoute(page: SecondRoute.page, path: '/second'),
  ];
}

final appRouter = locator<AppRouter>();
