import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_first_app/widget/figma_base_app_bar.dart';

import '../../../../../generated/assets.dart';
import '../../../../values/colors.dart';
import '../../../../values/style.dart';
import '../../../../widget/custom_checkBox_widgets.dart';
import 'widgets/custom_progress.dart';

@RoutePage()
class FigmaProfilePage extends StatefulWidget {
  const FigmaProfilePage({super.key});

  @override
  State<FigmaProfilePage> createState() => _FigmaProfilePageState();
}

class _FigmaProfilePageState extends State<FigmaProfilePage> {
  bool isOn = false;
  bool isRating = false;
  bool isNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // 👈 this allows bottomNavigationBar to draw over the body
      body: Stack(
        children: [
          Image.asset(
            Assets.imageFigmaImageSplash,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          Column(
            children: [
              FigmaBaseAppBar(title: "My Profile", isBack: true),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 25.h, top: 24.h), // optional bottom spacing
                  child: Column(
                    children: [
                      _profileDetails(),
                      SizedBox(height: 24.h),
                      _progressDetails(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _profileDetails() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: AppColor.darkBg.withOpacity(0.7),
        border: Border.all(color: AppColor.stroke),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w), // border padding
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.white, // border color
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      Assets.imagePlanet1,
                      width: 64.w,
                      height: 64.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Arthur Debt',
                      style: textFigtreeBold.copyWith(fontSize: 20.spMin),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Space adventurer',
                      style: textFigtreeRegular.copyWith(fontSize: 16.spMin),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Image.asset(
              Assets.imageBarIconEdit,
              width: 24.w,
              height: 24.w,
              color: AppColor.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _progressDetails() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: AppColor.darkBg.withOpacity(0.7),
        border: Border.all(color: AppColor.stroke),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: EdgeInsets.all(24).w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Switch(
                  value: isOn,
                  onChanged: (bool value) {
                    setState(() => isOn = value);
                  },
                  activeColor: AppColor.black,
                  activeTrackColor: AppColor.accent,
                  inactiveThumbColor: Colors.black,
                  inactiveTrackColor: Colors.white,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Show planetary progress',
                  style: textMedium.copyWith(
                    fontFamily: Assets.fontsFigtreeMedium,
                    color: AppColor.white,
                    fontSize: 14.spMin,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            Align(
              alignment: Alignment.center,
              child: GradientProgressBar(
                percentage: 87.1,
                size: 240, // set any size you want
              ),
            ),
            SizedBox(height: 32.h),
            CustomCheckbox(
              value: isRating,
              label: 'Show me in Planet Rating',
              onChanged: (val) {
                setState(() => isRating = val);
              },
            ),
            SizedBox(height: 30.h),
            CustomCheckbox(
              value: isNotification,
              label: 'Notifications',
              onChanged: (val) {
                setState(() => isNotification = val);
              },
            ),
          ],
        ),
      ),
    );
  }
}
