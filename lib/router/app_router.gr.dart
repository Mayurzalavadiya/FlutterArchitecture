// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AnimatedContainerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AnimatedContainerPage(),
      );
    },
    BottomNavRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BottomNavPage(),
      );
    },
    HeroAnimationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HeroAnimationPage(),
      );
    },
    HiveDataRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HiveDataPage(),
      );
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomePage(
          key: args.key,
          onSwitchToWidgets: args.onSwitchToWidgets,
          notificationCount: args.notificationCount,
        ),
      );
    },
    ImageVideoPickerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ImageVideoPickerPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    ProviderRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProviderPage(),
      );
    },
    QuotesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const QuotesPage(),
      );
    },
    SecondRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SecondPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    TweenAnimationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TweenAnimationPage(),
      );
    },
    WidgetsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WidgetsPage(),
      );
    },
  };
}

/// generated route for
/// [AnimatedContainerPage]
class AnimatedContainerRoute extends PageRouteInfo<void> {
  const AnimatedContainerRoute({List<PageRouteInfo>? children})
      : super(
          AnimatedContainerRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnimatedContainerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BottomNavPage]
class BottomNavRoute extends PageRouteInfo<void> {
  const BottomNavRoute({List<PageRouteInfo>? children})
      : super(
          BottomNavRoute.name,
          initialChildren: children,
        );

  static const String name = 'BottomNavRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HeroAnimationPage]
class HeroAnimationRoute extends PageRouteInfo<void> {
  const HeroAnimationRoute({List<PageRouteInfo>? children})
      : super(
          HeroAnimationRoute.name,
          initialChildren: children,
        );

  static const String name = 'HeroAnimationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HiveDataPage]
class HiveDataRoute extends PageRouteInfo<void> {
  const HiveDataRoute({List<PageRouteInfo>? children})
      : super(
          HiveDataRoute.name,
          initialChildren: children,
        );

  static const String name = 'HiveDataRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    required void Function()? onSwitchToWidgets,
    required int? notificationCount,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            key: key,
            onSwitchToWidgets: onSwitchToWidgets,
            notificationCount: notificationCount,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<HomeRouteArgs> page = PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    required this.onSwitchToWidgets,
    required this.notificationCount,
  });

  final Key? key;

  final void Function()? onSwitchToWidgets;

  final int? notificationCount;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, onSwitchToWidgets: $onSwitchToWidgets, notificationCount: $notificationCount}';
  }
}

/// generated route for
/// [ImageVideoPickerPage]
class ImageVideoPickerRoute extends PageRouteInfo<void> {
  const ImageVideoPickerRoute({List<PageRouteInfo>? children})
      : super(
          ImageVideoPickerRoute.name,
          initialChildren: children,
        );

  static const String name = 'ImageVideoPickerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProviderPage]
class ProviderRoute extends PageRouteInfo<void> {
  const ProviderRoute({List<PageRouteInfo>? children})
      : super(
          ProviderRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProviderRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [QuotesPage]
class QuotesRoute extends PageRouteInfo<void> {
  const QuotesRoute({List<PageRouteInfo>? children})
      : super(
          QuotesRoute.name,
          initialChildren: children,
        );

  static const String name = 'QuotesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SecondPage]
class SecondRoute extends PageRouteInfo<void> {
  const SecondRoute({List<PageRouteInfo>? children})
      : super(
          SecondRoute.name,
          initialChildren: children,
        );

  static const String name = 'SecondRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TweenAnimationPage]
class TweenAnimationRoute extends PageRouteInfo<void> {
  const TweenAnimationRoute({List<PageRouteInfo>? children})
      : super(
          TweenAnimationRoute.name,
          initialChildren: children,
        );

  static const String name = 'TweenAnimationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WidgetsPage]
class WidgetsRoute extends PageRouteInfo<void> {
  const WidgetsRoute({List<PageRouteInfo>? children})
      : super(
          WidgetsRoute.name,
          initialChildren: children,
        );

  static const String name = 'WidgetsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
