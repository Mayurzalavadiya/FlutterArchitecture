import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/values/colors.dart';

Future<bool> hasInternetConnection() async {
  final result = await Connectivity().checkConnectivity();
  return result != ConnectivityResult.none;
}

Future<void> showCommonDialog({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = false,
  double topPadding = 40,
  double width = 336,
}) {
  return showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black.withSafeOpacity(0.6),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) {
      return LayoutBuilder(builder: (context, _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: AnimatedPadding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: topPadding,
            ),
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            child: Center(
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        );
      });
    },
    transitionBuilder: (context, animation, _, widget) {
      return Transform.scale(
        scale: animation.value,
        child: Opacity(
          opacity: animation.value,
          child: widget,
        ),
      );
    },
  );
}


