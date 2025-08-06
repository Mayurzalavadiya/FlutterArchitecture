import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../generated/assets.dart';
import '../values/colors.dart';
import '../values/style.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: AppColor.black,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColor.text, width: 2),
            ),
            child: value
                ? Icon(Icons.check, size: 18.w, color: AppColor.accent)
                : null,
          ),
          SizedBox(width: 10.w),
          Text(
            label,
            style: textMedium.copyWith(
              fontFamily: Assets.fontsFigtreeMedium,
              fontSize: 14.spMin,
              color: AppColor.white,
            ),
          ),
        ],
      ),
    );
  }
}
