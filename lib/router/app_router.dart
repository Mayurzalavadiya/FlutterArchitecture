import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_first_app/ui/figma/ui/home/figma_favourites_page.dart';
import 'package:my_first_app/ui/figma/ui/home/figma_home_page.dart';

import '../core/locator/locator.dart';
import '../data/model/generalData/user_model.dart';
import '../data/model/response/get_cart_data.dart';
import '../ui/animation/animated_container_page.dart';
import '../ui/animation/hero_animation_page.dart';
import '../ui/animation/tween_animation_page.dart';
import '../ui/auth/login_page.dart';
import '../ui/editProfile/image_video_picker_page.dart';
import '../ui/figma/ui/auth/login/figma_login_page.dart';
import '../ui/figma/ui/home/figma_main_home_page.dart';
import '../ui/figma/ui/home/figma_planet_detail_page.dart';
import '../ui/figma/ui/profile/figma_profile_page.dart';
import '../ui/figma/ui/splash/figma_splash_page.dart';
import '../ui/figma2/MoodyPage.dart';
import '../ui/figma2/NewsPage.dart';
import '../ui/figma2/WorkOutAppPage.dart';
import '../ui/hive_data/ListPage.dart';
import '../ui/hive_data/detail_page.dart';
import '../ui/hive_data/edit_hive_data_page.dart';
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
    CustomRoute(page: ProviderRoute.page, path: '/provider', transitionsBuilder: (context, animation, _, child) {
      return RotationTransition(
        turns: Tween(begin: 0.95, end: 1.0).animate(animation),
        child: FadeTransition(opacity: animation, child: child),
      );
    }, durationInMilliseconds: 800,
    ),
    AutoRoute(page: ImageVideoPickerRoute.page, path: '/imagePicker'),
    AutoRoute(page: AnimatedContainerRoute.page, path: '/animationContainer'),
    AutoRoute(page: TweenAnimationRoute.page, path: '/tweenAnimation'),
    CustomRoute(
      page: HeroAnimationRoute.page,
      path: '/heroAnimation',
      transitionsBuilder: (context, animation, _, child) {
        final offset = Tween<Offset>(
          begin: Offset(0, 1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
        return SlideTransition(position: offset, child: child);
      },
      durationInMilliseconds: 800
    ),
    AutoRoute(page: SecondRoute.page, path: '/second'),
    AutoRoute(page: HiveDataRoute.page, path: '/HiveData', ),
    AutoRoute(page: EditHiveDataRoute.page, path: '/editHiveData', ),
    AutoRoute(page: ListRoute.page, ),
    AutoRoute(page: DetailRoute.page),

    CustomRoute(
      page: FigmaSplashRoute.page,
      path: '/figmaSplash',
      transitionsBuilder: TransitionsBuilders.zoomIn,
      durationInMilliseconds: 300,
    ),

    CustomRoute(
      page: FigmaLoginRoute.page,
      path: '/figmaLogin',
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: 800,
    ),

    // ✅ Tabs router setup
    CustomRoute(
      page: FigmaMainHomeRoute.page,
      path: '/figmaMainHome',
      transitionsBuilder: TransitionsBuilders.slideTop,
      durationInMilliseconds: 500,
      children: [
        AutoRoute(page: FigmaHomeRoute.page, path: 'home', initial: true),
        AutoRoute(page: FigmaFavouritesRoute.page, path: 'favourites'),
        AutoRoute(page: FigmaProfileRoute.page, path: 'profile'),
      ],
    ),

    AutoRoute(page: FigmaPlanetDetailRoute.page, path: '/figmaPlanetDetail'),
    CustomRoute(
      page: FigmaProfileRoute.page,
      path: '/figmaProfile',
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 800,
    ),
    
    //Figma2
    AutoRoute(page: MoodyRoute.page, path: '/moodyPage'),
    CustomRoute(
      page: WorkOutRoute.page,
      path: '/figmaWorkOut',
      transitionsBuilder: TransitionsBuilders.slideRightWithFade,
      durationInMilliseconds: 800,
    ),
    CustomRoute(
      page: NewsRoute.page,
      path: '/figmaWorkOut',
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 800,
    ),
  ];
}

final appRouter = locator<AppRouter>();
