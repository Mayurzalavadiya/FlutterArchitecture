import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_first_app/values/colors.dart';

import '../generated/assets.dart';

void showMessage(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    // backgroundColor: AppColor.brownColor,
    fontAsset: Assets.imageAddUser,
    timeInSecForIosWeb: 1,
    textColor: Colors.white,
    fontSize: 16.0.sp,
  );
}

FToast? _fToast;

void showCustomToast(
  BuildContext context, {
  String? message,
  IconData? icon,
  Color? backgroundColor,
  Color? textColor,
  Duration? duration,
  ToastGravity? gravity,
  double? borderRadius,
  BoxBorder? border,
  Gradient? gradient,
}) {
  if (message == null) return; // Don't show toast if no message

  _fToast ??= FToast();
  _fToast!.init(context);

  _fToast!.removeCustomToast();

  final toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(borderRadius ?? 25.0),
      color: backgroundColor ?? Colors.black87,
      border: border,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, color: textColor ?? Colors.white),
          const SizedBox(width: 12.0),
        ],
        Flexible(
          child: Text(
            message,
            style: TextStyle(color: textColor ?? Colors.white),
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    ),
  );

  _fToast!.showToast(
    child: toast,
    gravity: gravity ?? ToastGravity.TOP,
    toastDuration: duration ?? const Duration(seconds: 2),
  );
}

void showSnackBarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
  );
}

void showCustomSnackBar(
  BuildContext context, {
  required String message,
  Color backgroundColor = Colors.teal,
  Duration duration = const Duration(seconds: 2),
  SnackBarBehavior behavior = SnackBarBehavior.floating,
  IconData? icon,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: behavior,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, color: Colors.white),
          if (icon != null) const SizedBox(width: 8),
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}
