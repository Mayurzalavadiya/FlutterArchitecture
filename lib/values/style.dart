import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../generated/assets.dart';
import 'colors.dart';

final TextStyle textThin = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w100,
  fontSize: 16.spMin,
  color: AppColor.black,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textExtraLight = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w200,
  fontSize: 16.spMin,
  color: AppColor.black,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textLight = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w300,
  fontSize: 16.spMin,
  color: AppColor.black,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textRegular = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w400,
  fontSize: 16.spMin,
  color: AppColor.black,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textFigtreeRegular = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w400,
  fontFamily: Assets.fontsFigtreeRegular,
  fontSize: 18.spMin,
  color: AppColor.text,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textMedium = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w500,
  fontFamily: Assets.fontsRotundaBold,
  fontSize: 16.spMin,
  color: AppColor.black,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textSemiBold = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w600,
  fontSize: 16.spMin,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textBold = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w700,
  fontFamily: Assets.fontsRotundaBold,
  fontSize: 16.spMin,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textFigtreeBold = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w700,
  fontFamily: Assets.fontsFigtreeBold,
  fontSize: 18.spMin,
  color: AppColor.white,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textExtraBold = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w800,
  fontSize: 16.spMin,
  fontFamily: Assets.fontsFigtreeExtraBold,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textBlack = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w900,
  fontSize: 26.spMin,
  overflow: TextOverflow.ellipsis,
);

final BoxDecoration boxDecoration = BoxDecoration(
  borderRadius: BorderRadiusGeometry.circular(8.r),
);

final BoxDecoration figmaBoxDecoration = BoxDecoration(
  color: AppColor.darkBg.withSafeOpacity(0.7), // Background color
  borderRadius: BorderRadius.all(Radius.circular(50.r)),
  border: Border.all(width: 1, color: AppColor.stroke),
);
