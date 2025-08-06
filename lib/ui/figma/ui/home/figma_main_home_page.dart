import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_first_app/values/colors.dart';
import 'package:my_first_app/widget/figma_base_app_bar.dart';

import '../../../../generated/assets.dart';
import '../../../../router/app_router.dart';
import '../app_globals.dart';
import 'package:auto_route/auto_route.dart';


@RoutePage()
class FigmaMainHomePage extends StatefulWidget {
  const FigmaMainHomePage({super.key});

  @override
  State<FigmaMainHomePage> createState() => _FigmaMainHomePageState();
}

class _FigmaMainHomePageState extends State<FigmaMainHomePage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        FigmaHomeRoute(),
        FigmaFavouritesRoute(),
        FigmaFavouritesRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final index = tabsRouter.activeIndex;
          if (index == 0) {
            appBarGlobalKey.currentState?.setTitle('Solar System');
            appBarGlobalKey.currentState?.setSubTitle('Milky Way');
          } else if (index == 1) {
            appBarGlobalKey.currentState?.setTitle('Favourite');
            appBarGlobalKey.currentState?.setSubTitle('');
          } else if (index == 2) {
            appBarGlobalKey.currentState?.setTitle('Profile');
            appBarGlobalKey.currentState?.setSubTitle('');
          }
        });

        return Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              Image.asset(
                Assets.imageFigmaImageSplash,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned.fill(child: child), // 👈 auto_route handles the tab screen

              FigmaBaseAppBar(
                key: appBarGlobalKey,
                title: "Solar System",
                subTitle: 'Miky Way',
              ),
            ],
          ),
          bottomNavigationBar: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColor.darkBg.withOpacity(0.7),
              borderRadius: BorderRadius.all(Radius.circular(15).r),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              selectedItemColor: AppColor.white,
              unselectedItemColor: AppColor.text,
              elevation: 0,
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) => tabsRouter.setActiveIndex(index),
              items: [
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(Assets.imageFigmaIconHome),
                    size: 24,
                    color: tabsRouter.activeIndex == 0 ? AppColor.accent : AppColor.text,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(Assets.imageTabIcon),
                    size: 24,
                    color: tabsRouter.activeIndex == 1 ? AppColor.accent : AppColor.text,
                  ),
                  label: 'Favourites',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(Assets.imageIconMore),
                    size: 24,
                    color: tabsRouter.activeIndex == 2 ? AppColor.accent : AppColor.text,
                  ),
                  label: 'More',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
