import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_first_app/generated/assets.dart';
import 'package:my_first_app/values/export.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../router/app_router.dart';
import '../../widget/CustomBottomNavBar.dart';

@RoutePage()
class MoodyPage extends StatefulWidget {
  const MoodyPage({super.key});

  @override
  State<MoodyPage> createState() => _MoodyPageState();
}

class _MoodyPageState extends State<MoodyPage> {
  int selectionIndex = 1;

  final PageController _controller = PageController(viewportFraction: 0.85);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: selectionIndex,
        onTap: (value) {

          setState(() {
            selectionIndex = value;
          });
          if (value == 0) {
            context.router.push(WorkOutRoute());
          } else if (value == 1) {
          } else if (value == 2) {
            context.router.push(NewsRoute());
          }
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          // only top & bottom
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(Assets.imageFigma2Logo, height: 40),
                        Stack(
                          children: [
                            Icon(Icons.notifications_none, color: Colors.black),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text.rich(
                      TextSpan(
                        text: 'Hello, ',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Sara Rose',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'How are you feeling today ?',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (index) {
                        final icons = ['😍', '😎', '😊', '😟'];
                        final name = ['Love', 'Cool', 'Happy', 'Sad'];
                        return Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xFFE4E7EC),
                              child: Text(
                                icons[index],
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(name[index], style: textRegular),
                          ],
                        );
                      }),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Feature',
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
                              style: TextStyle(color: Color(0xFF027A48)),
                            ),
                            Icon(
                              Icons.chevron_right_sharp,
                              color: Color(0xFF027A48),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12),
              SizedBox(
                height: 160.h,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: 3,
                  itemBuilder: (_, index) => Padding(
                    padding: EdgeInsets.only(right: index != 2 ? 16.w : 0),
                    child: _buildCard(),
                  ),
                ),
              ),
              SizedBox(height: 12),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 8,
                      activeDotColor: Color(0xFF98A2B3),
                      dotColor: Color(0xFFD9D9D9),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Exercise',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'See more',
                              style: TextStyle(color: Color(0xFF027A48)),
                            ),
                            Icon(
                              Icons.chevron_right_sharp,
                              color: Color(0xFF027A48),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      crossAxisSpacing: 24,
                      childAspectRatio: 2.5,
                      mainAxisSpacing: 16,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        _buildCategoryCard(
                          'Relaxation',
                          Icons.psychology,
                          Color(0xFFF9F5FF),
                        ),
                        _buildCategoryCard(
                          'Meditation',
                          Icons.self_improvement,
                          Color(0xFFFDF2FA),
                        ),
                        _buildCategoryCard(
                          'Beathing',
                          Icons.air,
                          Color(0xFFFFFAF5),
                        ),
                        _buildCategoryCard(
                          'Yoga',
                          Icons.accessibility_new,
                          Color(0xFFF0F9FF),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, size: 32),
          SizedBox(width: 12),
          Expanded(child: Text(title, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Positive vibes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF344054),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Boost your mood with\npositive vibes',
                  style: textRegular.copyWith(fontSize: 14.sp),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.play_circle_fill, color: Colors.green),
                    SizedBox(width: 6),
                    Text('10 mins'),
                  ],
                ),
              ],
            ),
          ),
          Image.asset(Assets.imageWalkingTheDog, height: 90.h, width: 102.w),
        ],
      ),
    );
  }
}
