import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_first_app/values/colors.dart';
import 'package:my_first_app/widget/figma_base_app_bar.dart';

import '../../../../generated/assets.dart';
import '../../../../values/style.dart';
import '../app_globals.dart';

@RoutePage()
class FigmaHomePage extends StatefulWidget {
  const FigmaHomePage({super.key});

  @override
  State<FigmaHomePage> createState() => _FigmaHomePageState();
}

class _FigmaHomePageState extends State<FigmaHomePage> {
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
      body: SingleChildScrollView( // ✅ correct place to scroll
        padding: EdgeInsets.only(top: 120.h, bottom: 50.h), // 👈 add padding to avoid overlap with bottom nav
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _planetList(),
            SizedBox(height: 24.h),
            _planetDes(),
          ],
        ),
      ),
    );
  }

  Widget _planetList() {
    return SizedBox(
      height: 48.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: planetList.length,
        padding: EdgeInsets.only(left: 24.w, right: 12.w),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColor.darkBg,
                border: Border.all(color: AppColor.stroke),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.imagePlanet1,
                    height: 24.w,
                    width: 24.w,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    planetList[index],
                    style: textFigtreeBold.copyWith(
                      fontSize: 14.spMin,
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _planetDes() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          _planetCard(),
          SizedBox(height: 26.h),
          _solarSystemCard(),
        ],
      ),
    );
  }

  Widget _planetCard() {
    return Container(
      width: double.infinity,
      decoration: figmaBoxDecoration.copyWith(
        borderRadius: BorderRadius.all(Radius.circular(28.r)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          right: 29.w,
          bottom: 19.h,
          top: 21.h,
          left: 24.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Planet of the day',
              style: textBold.copyWith(
                fontFamily: Assets.fontsFigtreeBold,
                fontSize: 20.spMin,
                color: AppColor.white,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    Assets.imagePlanet1,
                    height: 60.h,
                    width: 60.w,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mars',
                        style: textBold.copyWith(
                          fontFamily: Assets.fontsFigtreeBold,
                          fontSize: 20.spMin,
                          color: AppColor.accent,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System, only being larger than Mercury. In the English language, Mars is named for the Roman god of war.',
                        style: textBold.copyWith(
                          fontFamily: Assets.fontsFigtreeRegular,
                          fontSize: 12.spMin,
                          color: AppColor.white,
                        ),
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                      SizedBox(height: 12.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Details',
                              style: textBold.copyWith(
                                fontFamily: Assets.fontsFigtreeBold,
                                fontSize: 14.spMin,
                                color: AppColor.white,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: AppColor.accent,
                              size: 20.w,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _solarSystemCard() {
    return Container(
      width: double.infinity,
      decoration: figmaBoxDecoration.copyWith(
        borderRadius: BorderRadius.all(Radius.circular(28.r)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 21.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Solar System',
              style: textBold.copyWith(
                fontFamily: Assets.fontsFigtreeBold,
                fontSize: 20.spMin,
                color: AppColor.white,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "The Solar System is the gravitationally bound system of the Sun and the objects that orbit it. It formed 4.6 billion years ago from a giant interstellar cloud. The majority of the system's mass is in the Sun, with the rest mostly in Jupiter. The four inner planets—Mercury, Venus, Earth, Mars—are rocky. The four outer planets are gas giants.",
              style: textBold.copyWith(
                fontFamily: Assets.fontsFigtreeRegular,
                fontSize: 14.spMin,
                color: AppColor.white,
              ),
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
