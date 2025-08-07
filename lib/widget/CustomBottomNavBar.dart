import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../generated/assets.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      elevation: 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (index) {
          final isSelected = index == currentIndex;
          final icons = [
            Icons.window,
            Icons.home,
            Icons.date_range,
          ];

          return GestureDetector(
            onTap: () => onTap(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icons[index],
                    color: isSelected ? Color(0xFF027A48) : Color(0xFF667085),
                  ),
                  const SizedBox(height: 4),
                  isSelected
                      ? Image.asset(
                    Assets.imageEllipse6,
                    height: 8,
                    width: 8,
                  )
                      : const SizedBox(height: 8), // keep space consistent
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
