import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_first_app/router/app_router.dart';
import 'package:my_first_app/values/colors.dart';
import 'package:my_first_app/widget/figma_base_app_bar.dart';

import '../../../../generated/assets.dart';
import '../../../../values/style.dart';
import '../app_globals.dart';

@RoutePage()
class FigmaFavouritesPage extends StatefulWidget {
  const FigmaFavouritesPage({super.key});

  @override
  State<FigmaFavouritesPage> createState() => _FigmaFavouritesPageState();
}

class _FigmaFavouritesPageState extends State<FigmaFavouritesPage> {
  final List<String> planetList = [
    'Mercury',
    'Venus',
    'Earth',
    'Mars',
    'Jupiter',
    'Saturn',
    'Uranus',
    'Neptune',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColor.transparent,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: 50.h,
          top: 120.h,
          right: 24.w,
          left: 24.w,
        ),
        child: Column(
          children: List.generate(planetList.length, (index) {
            return _planetCard(index);
          }),
        ),
      ),
    );
  }

  Widget _planetCard(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.darkBg.withOpacity(0.7),
        border: Border.all(color: AppColor.stroke),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            Assets.imagePlanet1,
            height: 60.w,
            width: 60.w,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      planetList[index],
                      style: textFigtreeBold.copyWith(
                        fontSize: 20.spMin,
                        color: AppColor.accent,
                      ),
                    ),
                    Image.asset(
                      Assets.imageTabIcon,
                      height: 24.w,
                      width: 24.w,
                      color: AppColor.white,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  'Mercury is the smallest planet in the Solar System and the closest to the Sun.',
                  style: textBold.copyWith(
                    fontSize: 12.spMin,
                    color: AppColor.white,
                    fontFamily: Assets.fontsFigtreeRegular,
                  ),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Details',
                      style: textBold.copyWith(
                        fontSize: 14.spMin,
                        fontFamily: Assets.fontsFigtreeBold,
                        color: AppColor.white,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: () {
                        context.router.push(FigmaPlanetDetailRoute());
                      },
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColor.accent,
                        size: 20.w,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
