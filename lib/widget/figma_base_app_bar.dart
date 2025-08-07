import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_first_app/router/app_router.dart';
import 'package:my_first_app/ui/figma/ui/home/figma_main_home_page.dart';
import 'package:my_first_app/widget/base_app_bar.dart';

import '../generated/assets.dart';
import '../values/colors.dart';
import '../values/style.dart';

class FigmaBaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final String? subTitle;
  final VoidCallback? backAction;
  final bool isBack;
  final bool isFavourite;

  const FigmaBaseAppBar({
    super.key,
    this.title,
    this.subTitle = '',
    this.backAction,
    this.isBack = false,
    this.isFavourite = false,
    this.preferredSize = const Size.fromHeight(kToolbarHeight),
  });

  @override
  final Size preferredSize;

  @override
  State<FigmaBaseAppBar> createState() => FigmaBaseAppBarState();
}

class FigmaBaseAppBarState extends State<FigmaBaseAppBar> {
  late String? _title;
  String? _subTitle;
  bool _isBack = false;
  bool _isFavourite = false;

  @override
  void initState() {
    super.initState();
    setStatusBarColor(color: AppColor.transparent);
    _title = widget.title;
    _subTitle = widget.subTitle;
    _isBack = widget.isBack;
    _isFavourite = widget.isFavourite;
  }

  void setTitle(String title) {
    setState(() {
      _title = title;
    });
  }

  void setSubTitle(String subTitle) {
    setState(() {
      _subTitle = subTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105.h,
      width: double.infinity,
        decoration: !_isFavourite
            ? BoxDecoration(
          color: AppColor.darkBg.withSafeOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(25).r),
          border: Border.all(width: 2.w, color: AppColor.stroke),
        )
            : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 35.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (_isBack) {
                      context.router.maybePop();
                    } else {}
                  },
                  child: Image.asset(
                    _isBack ? Assets.imageFigmaBack : Assets.imageActionTopMenu,
                    height: 60.w,
                    width: 60.w,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_subTitle != null)
                      Text(
                        _subTitle ?? "",
                        style: textFigtreeRegular.copyWith(
                          fontSize: 10.spMin,
                          color: AppColor.text,
                        ),
                      ),

                      if (_title != null)
                      Text(
                        _title??"",
                        style: textExtraBold.copyWith(
                          fontSize: 25.spMin,
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                _isFavourite
                    ? GestureDetector(
                        onTap: () {
                          context.router.push(FigmaProfileRoute());
                        },
                        child: Image.asset(
                          Assets.imageGroup312,
                          height: 60.w,
                          width: 60.w,
                        ),
                      )
                    : _isBack
                    ? SizedBox(width: 60.w)
                    : GestureDetector(
                        onTap: () {
                          context.router.push(FigmaProfileRoute());
                        },
                        child: Image.asset(
                          Assets.imageProfile,
                          height: 60.w,
                          width: 60.w,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
