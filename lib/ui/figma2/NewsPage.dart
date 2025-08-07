import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_first_app/generated/assets.dart';
import 'package:my_first_app/values/export.dart';

@RoutePage()
class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int selectedIndex = 0;

  final PageController _pageController = PageController(
    viewportFraction: 0.85,
  ); // Adjust card width here
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(Duration(seconds: 3), (_) {
      if (!_pageController.hasClients) return;
      final nextPage = _currentPage + 1;
      if (nextPage >= cards.length) {
        _currentPage = 0;
      } else {
        _currentPage = nextPage;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  final List<String> tabs = [
    "Discover",
    "News",
    "Most Viewed",
    "Saved",
    "Liked",
    "Trending",
    "Popular",
    "Latest",
    "Trending",
    "Mixed",
  ];

  final List<Map<String, dynamic>> cards = [
    {
      'title': '10 Easy Self-Care Ideas That Can Help Boost Your Health',
      'subtitle': 'SELF-CARE',
      'image': Assets.imageNewsFrame1,
      'chipColor': Color(0xFFFEF0C7),
      'chipTextColor': Color(0xFF93370D),
    },
    {
      'title': 'How to take care of Menstrual Hygiene during Menstrual Cycle',
      'subtitle': 'CYCLE',
      'image': Assets.imageNewsFrame2,
      'chipColor': Color(0xFFFEE4E2),
      'chipTextColor': Color(0xFF912018),
    },
    {
      'title': 'Top Yoga Poses to Start Your Day Right',
      'subtitle': 'YOGA',
      'image': Assets.imageNewsFrame1,
      'chipColor': Color(0xFFFEF0C7),
      'chipTextColor': Color(0xFF912018),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Image.asset(Assets.imageNewsLogo, height: 32.h),
            Padding(
              padding: EdgeInsets.only(top: 24, right: 32, left: 32),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Articles, Video, Audio and More,...",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              height: 40, // Set height to fit chips properly
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                itemCount: tabs.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final title = tabs[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: customChip(title, index == selectedIndex),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32).w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hot topics',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'See more',
                        style: TextStyle(color: Color(0xFF5925DC)),
                      ),
                      Icon(Icons.chevron_right_sharp, color: Color(0xFF5925DC)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              height: 160.h,
              child: PageView.builder(
                controller: _pageController,
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return discoverCard(
                    title: card['title']!,
                    subtitle: card['subtitle']!,
                    image: card['image']!,
                    chipColor: card['chipColor']!,
                    chipTextColor: card['chipTextColor']!,
                  );
                },
                onPageChanged: (index) => _currentPage = index,
              ),
            ),

            SizedBox(height: 24),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Get Tips',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'See more',
                            style: TextStyle(color: Color(0xFF5925DC)),
                          ),
                          Icon(Icons.chevron_right_sharp, color: Color(0xFF5925DC)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  doctorSuggestionCard(
                    image: Assets.imageDoctorPNGImages,
                    onPressed: () {
                      // Handle button click here
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget customChip(String label, bool isSelected) {
  return Chip(
    label: Text(label),
    backgroundColor: isSelected ? Color(0xFFF4EBFF) : AppColor.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
      side: BorderSide(
        color: isSelected ? Color(0xFFD6BBFB) : Color(0xFFE4E7EC),
        width: 1,
      ),
    ),
  );
}

Widget discoverCard({
  required String title,
  required String subtitle,
  required String image,
  required Color chipColor,
  required Color chipTextColor,
}) {
  return Container(
    margin: EdgeInsetsGeometry.only(right: 8.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      image: DecorationImage(
        image: AssetImage(image),
        fit: BoxFit.cover,
        /*  colorFilter: ColorFilter.mode(
        Colors.black.withSafeOpacity(0.2),
        BlendMode.darken,
      ),*/
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(
                  label: Text(subtitle, style: TextStyle(color: chipTextColor)),
                  backgroundColor: chipColor,
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget doctorSuggestionCard({
  required String image,
  required VoidCallback onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFFF8F9FB),
      border: Border.all(color: Color(0xFFE4E7EC), width: 1, strokeAlign: BorderSide.strokeAlignInside),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Padding(
          padding:  EdgeInsets.only(left: 11.74.w, top: 27.h),
          child: Image.asset(image, width: 110),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Connect with doctors & get suggestions",
                  style: textBold.copyWith( overflow: TextOverflow.visible),
                ),
                SizedBox(height: 8),
                Text("Connect now and get expert insights"),
                SizedBox(height: 10),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: 8,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF7F56D9),
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    ),
                    child: Text(
                      "View detail",
                      style: textRegular.copyWith(color: AppColor.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
