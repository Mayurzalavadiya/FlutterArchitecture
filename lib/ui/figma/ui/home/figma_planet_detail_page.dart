import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_first_app/values/colors.dart';
import 'package:my_first_app/values/extensions/int_ext.dart';
import 'package:my_first_app/widget/figma_base_app_bar.dart';

import '../../../../data/model/generalData/planets_model.dart';
import '../../../../generated/assets.dart';
import '../../../../values/style.dart';
import '../app_globals.dart';

@RoutePage()
class FigmaPlanetDetailPage extends StatefulWidget {
  const FigmaPlanetDetailPage({super.key});

  @override
  State<FigmaPlanetDetailPage> createState() => _FigmaPlanetDetailPageState();
}

class _FigmaPlanetDetailPageState extends State<FigmaPlanetDetailPage> {
  bool isOn = false;
  bool isRating = false;
  bool isNotification = false;

  final List<PlanetsModel> planetDetails = [
    PlanetsModel(icon: Icons.scale, label: 'Mass\n(10²⁴kg)', value: '5.97'),
    PlanetsModel(icon: Icons.add, label: 'Gravity\n(m/s²)', value: '9.8'),
    PlanetsModel(icon: Icons.wb_sunny, label: 'Day\n(hours)', value: '24'),
    PlanetsModel(
      icon: Icons.rocket_launch,
      label: 'Esc. Velocity\n(km/s)',
      value: '11.2',
    ),
    PlanetsModel(icon: Icons.thermostat, label: 'Mean Temp\n(°C)', value: '15'),
    PlanetsModel(
      icon: Icons.straighten,
      label: 'Distance from\nSun (10⁶ km)',
      value: '5.97',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // 👈 this allows bottomNavigationBar to draw over the body
      body: Stack(
        children: [
          Image.asset(
            Assets.imageGroup1,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          Expanded(
            child: SingleChildScrollView(
              // optional bottom spacing
              padding: EdgeInsetsGeometry.only(top: 100.h),
              child: Column(
                children: [
                  SizedBox(height: 100.h),
                  _planetDetails(),
                ],
              ),
            ),
          ),

          Column(children: [FigmaBaseAppBar(isBack: true, isFavourite: true)]),
        ],
      ),
    );
  }

  Widget _planetDetails() {
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main card
          Container(
            constraints: BoxConstraints(
              minHeight: screenHeight - 202.h, // subtract top bar & spacing
            ),
            padding: EdgeInsets.only(top: 60.h),
            decoration: BoxDecoration(
              color: AppColor.darkBg.withOpacity(0.7),
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(
                width: 1,
                color: AppColor.stroke,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Earth',
                  style: textExtraBold.copyWith(
                    fontSize: 28.spMin,
                    color: AppColor.white,
                    fontFamily: Assets.fontsFigtreeExtraBold,
                  ),
                ),
                SizedBox(height: 32.h),

                _statItem(planetDetails),

                SizedBox(height: 32.h),

                // Visit Button
                Container(
                  height: 48.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF58CFFB), Color(0xFFBC6FF1)],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Visit',
                      style: textFigtreeBold.copyWith(fontSize: 18.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Planet image (overlapping top center)
          Positioned(
            top: -50.h,
            left: 0,
            right: 0,
            child: Center(
              child: CircleAvatar(
                radius: 55.r,
                backgroundImage: AssetImage(
                  Assets.imagePlanet1,
                ), // <- your image
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(List<PlanetsModel> items) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.9,
        mainAxisSpacing: 24.h,
      ),
      itemCount: planetDetails.length,
      itemBuilder: (context, index) {
        final item = planetDetails[index];

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, color: Colors.white, size: 40),
            SizedBox(height: 8.h),
            Text(
              item.label,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 12.sp),
            ),
            SizedBox(height: 4.h),
            Text(item.value, style: textFigtreeBold.copyWith(fontSize: 20.sp)),
          ],
        );
      },
    );
  }
}
