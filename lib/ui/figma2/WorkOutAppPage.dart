import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_first_app/core/db/share_pref.dart';
import 'package:my_first_app/generated/assets.dart';
import 'package:my_first_app/values/export.dart';

@RoutePage()
class WorkOutPage extends StatefulWidget {
  const WorkOutPage({super.key});

  @override
  State<WorkOutPage> createState() => _WorkOutPageState();
}

class _WorkOutPageState extends State<WorkOutPage> {
  int selectedIndex = 0;

  final List<String> tabTitles = ["All Type", "Full Body", "Upper", "Lower"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1754006320747-a90ba54b93cd?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDI1fHRvd0paRnNrcEdnfHxlbnwwfHx8fHw%3D',
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hello, ${appPreferences.user?.name}'),
                          Text('Ready to workout?', style: textSemiBold),
                        ],
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Icon(Icons.notifications, color: Colors.black),
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
              SizedBox(height: 23.h),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _dashboardItem(
                        title: "Heart Rate",
                        value: "81 BPM",
                        icon: Icons.favorite_border,
                      ),
                      SizedBox(width: 8),
                      VerticalDivider(
                        width: 1,
                        color: Color(0xFFD9D9D9),
                        thickness: 1,
                      ),
                      SizedBox(width: 8),
                      _dashboardItem(
                        title: "To-do",
                        value: "32.5%",
                        icon: Icons.list,
                      ),
                      SizedBox(width: 8),
                      VerticalDivider(
                        width: 1,
                        color: Color(0xFFD9D9D9),
                        thickness: 1,
                      ),
                      SizedBox(width: 8),
                      _dashboardItem(
                        title: "Calo",
                        value: "1000 Cal",
                        icon: Icons.local_fire_department,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24),
              Text(
                'Workout Programs',
                style: textBold.copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(tabTitles.length, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: workoutTab(
                        title: tabTitles[index],
                        isSelected: selectedIndex == index,
                      ),
                    ),
                  );
                }),
              ),
              Expanded(child: _workoutList()),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _dashboardItem({
  required String title,
  required String value,
  required IconData icon,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        children: [
          Icon(icon, color: Colors.deepPurple, size: 16),
          SizedBox(width: 4),
          Text(title, style: TextStyle(color: Colors.black54)),
        ],
      ),
      SizedBox(height: 4),
      Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ],
  );
}

Widget workoutTab({required String title, required bool isSelected}) {
  return Column(
    children: [
      Text(
        title,
        style: TextStyle(
          color: isSelected ? Color(0xFF363F72) : Color(0xFF667085),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      const SizedBox(height: 12),
      SizedBox(
        height: 5,
        child: Stack(
          children: [
            isSelected
                ? Container(
                    height: 5,
                    width: double.infinity,
                    color: Color(0xFF363F72),
                  )
                : Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: Color(0xFF667085),
                    ),
                  ),
          ],
        ),
      ),
    ],
  );
}

Widget _workoutList() {
  return ListView(
    children: [
      SizedBox(height: 24),
      workoutCard(
        days: "7 days",
        title: "Morning Yoga",
        subtitle: "Improve mental focus.",
        image: Assets.imageMorningYoga,
      ),
      workoutCard(
        days: "3 days",
        title: "Plank Exercise",
        subtitle: "Improve posture and stability.",
        image: Assets.imagePngwing1,
      ),
      workoutCard(
        days: "3 days",
        title: "Plank Exercise",
        subtitle: "Improve posture and stability.",
        image: Assets.imagePngwing1,
      ),
    ],
  );
}

Widget workoutCard({
  required String days,
  required String title,
  required String subtitle,
  required String image,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFF8F9FB),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Chip(
                label: Text(days),
                backgroundColor: Color(0xFFFCFCFD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Color(0xFFE4E7EC), width: 1),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(subtitle),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.schedule, size: 16),
                  SizedBox(width: 4),
                  Text("30 mins"),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Image.asset(image, width: 118.w, height: 100, fit: BoxFit.contain),
      ],
    ),
  );
}
