import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../generated/assets.dart';
import '../values/colors.dart';
import '../values/style.dart';

//ignore: must_be_immutable
class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  late String? title;
  bool centerTitle = false;
  late Color? backgroundColor;
  late double? elevations;
  late double? scrolledUnderElevation;
  List<Widget>? action;
  bool leadingIcon = false;
  bool showTitle = false;
  VoidCallback? backAction;
  Widget? titleWidget;
  Widget? leadingWidget;
  Color? leadingWidgetColor;
  Color? titleWidgetColor;
  Color? statusBarColor;
  bool statusBarOverLap = false;

  BaseAppBar({
    super.key,
    this.title,
    this.centerTitle = true,
    this.backgroundColor = AppColor.primaryColor,
    this.elevations = 0.0,
    this.scrolledUnderElevation = 0.0,
    this.action,
    this.leadingIcon = false,
    this.showTitle = false,
    this.backAction,
    this.titleWidget,
    this.leadingWidget,
    this.leadingWidgetColor,
    this.titleWidgetColor,
    this.statusBarColor,
    this.statusBarOverLap = false,
    this.preferredSize = const Size.fromHeight(kToolbarHeight),
  }) : assert(
  title == null || titleWidget == null,
  "Title and Title widget both can't be null",
  );

  @override
  final Size preferredSize; // default is 56.0

  @override
  State<BaseAppBar> createState() => _BaseAppBarState();
}

class _BaseAppBarState extends State<BaseAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: widget.centerTitle,
      title: !widget.showTitle
          ? const SizedBox.shrink()
          : widget.titleWidget ??
          Text(
            widget.title!,
            style: textBold.copyWith(
              fontSize: 19.spMin,
              color: widget.titleWidgetColor,
            ),
          ),
      backgroundColor: widget.backgroundColor ?? AppColor.white,
      elevation: widget.elevations,
      scrolledUnderElevation: widget.scrolledUnderElevation,
      automaticallyImplyLeading: false,
      leading: widget.leadingIcon
          ? widget.leadingWidget ??
          IconButton(
            icon: Image.asset(
              Assets.imagePrevious,
              height: 20.0,
              width: 24.0,
              color: widget.leadingWidgetColor,
            ),
            onPressed: () {
              if (widget.backAction != null) {
                widget.backAction!.call();
              } else {
                // context.router.pop();
                Navigator.maybePop(context);
              }
            },
          )
          : null,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: widget.action,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: widget.statusBarOverLap
              ? widget.statusBarColor ?? widget.backgroundColor
              : widget.statusBarColor ?? AppColor.primaryColor,
          // status bar bg color
          statusBarIconBrightness: widget.statusBarColor == Colors.white ||
              widget.backgroundColor == Colors.white
              ? Brightness.dark
              : Brightness.light,
          // icon/text color for Android
          statusBarBrightness: widget.statusBarColor == Colors.white ||
              widget.backgroundColor == Colors.white
              ? Brightness.dark
              : Brightness.light, // status bar text color for iOS
      ),
    );
  }
}

void setStatusBarColor({
  Color color = AppColor.primaryColor,
  Brightness iconBrightness = Brightness.light,
}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: iconBrightness,
      statusBarBrightness: iconBrightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark, // for iOS
    ),
  );
}
