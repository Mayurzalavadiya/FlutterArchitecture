import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_first_app/utils/analytics.dart';
import 'package:my_first_app/utils/permissions.dart';
import 'package:my_first_app/values/export.dart';
import 'package:my_first_app/widget/show_message.dart';

import '../../utils/notification_service.dart';

@RoutePage()
class WidgetsPage extends StatefulWidget {
  const WidgetsPage({super.key});

  @override
  State<WidgetsPage> createState() => _WidgetsPageState();
}

class _WidgetsPageState extends State<WidgetsPage> {
  bool? isChecked = false;
  int selectedValue = 0;
  int selectedIndex = 1;
  bool isOn = false;
  List<String> options = []; // Dynamic list
  String? selected; // Selected item

  @override
  void initState() {
    super.initState();
    fetchOptions();
  }


  void fetchOptions() async {
    await Future.delayed(Duration(seconds: 5)); // simulate delay
    setState(() {
      options = ['Option 1', 'Option 2', 'Option 3'];
      selected = options.first; // set initial selected value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello HOW R U    KJHKHJJKHJKHJK!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                NotificationService.showLocalNotification(
                  RemoteMessage(
                    notification: RemoteNotification(
                      title: "🎉 Task Complete",
                      body: "You just triggered a local notification",
                    ),
                    data: {},
                  ),
                );
                showMessage("clicked");
              },
              child: Text('Press Me'),
            ),
            Icon(Icons.favorite, color: Colors.red, size: 40),
            //for example:
            SizedBox(height: 10),

            //If you want to display a rectangle:
            Stack(
              children: [
                Container(
                  color: AppColor.primaryColor,
                  width: 200.w,
                  height: 200.h,
                ),

                Positioned(
                  top: 50,
                  right: 20,
                  child: Text(
                    'On top!',
                    style: textExtraBold.copyWith(
                      color: AppColor.white,
                      fontSize: 25.sp,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),
            //If you want to display a square based on width:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal,
                        blurRadius: 10,
                        offset: Offset(5, 5),
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.pink],
                    ),
                    // color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(15).r,
                    // shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Colors.black,
                      width: 3.w,
                      style: BorderStyle.solid,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),

                  width: 100.w,
                  height: 100.w,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(10.w),
                      // Removes default padding
                      backgroundColor: Colors.lightBlue, // Optional
                    ),
                    onLongPress: () => showCustomToast(
                      context,
                      message: "long press",
                      backgroundColor: AppColor.red,
                    ),
                    onPressed: () => showMessage("click text button"),
                    child: Text(
                      'Text Button',
                      // style: textBold.copyWith(
                      //   color: AppColor.white,
                      //   backgroundColor: AppColor.colorHint,
                      // ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // Removes default padding
                    backgroundColor: Colors.deepOrangeAccent, // Optional
                  ),
                  onLongPress: () => showCustomToast(
                    context,
                    message: "long press",
                    backgroundColor: AppColor.red,
                  ),
                  onPressed: () => showMessage("click text button"),
                  child: Text(
                    'Text Button',
                    style: textBold.copyWith(
                      backgroundColor: AppColor.colorHint,
                    ),
                  ),
                ),
                IconButton(icon: Icon(Icons.thumb_up), onPressed: () {}),
              ],
            ),
            SizedBox(height: 10.h),

            //If you want to display a square based on height:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() => isChecked = value!);
                  },
                ),

                Checkbox(
                  tristate: true,
                  value: isChecked, // can be true, false, or null
                  onChanged: (bool? value) {
                    setState(() => isChecked = value!);
                  },
                ),
                Checkbox(
                  value: isChecked,
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onChanged: (value) => setState(() => isChecked = value!),
                ),
              ],
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch(
                  value: isOn,
                  onChanged: (bool value) {
                    setState(() => isOn = value);
                  },
                ),
                Switch(
                  value: isOn,
                  onChanged: (bool value) {
                    setState(() => isOn = value);
                  },
                  activeColor: Colors.red,
                  activeTrackColor: Colors.black,
                  inactiveThumbColor: Colors.black,
                  inactiveTrackColor: Colors.white,
                ),
                Switch.adaptive(
                  value: isOn,
                  onChanged: (bool value) {
                    setState(() => isOn = value);
                  },
                ),
              ],
            ),

            SizedBox(height: 10),

            Radio<int>(
              value: 1,
              groupValue: selectedValue,
              onChanged: (int? value) {
                setState(() => selectedValue = value!);
              },
            ),
            Row(
              children: [
                Radio<int>(
                  value: 2,
                  groupValue: selectedValue,
                  onChanged: (val) => setState(() => selectedValue = val!),
                ),
                Radio<int>(
                  value: 3,
                  groupValue: selectedValue,
                  onChanged: (val) => setState(() => selectedValue = val!),
                ),
              ],
            ),

            Radio(
              value: 1,
              groupValue: selectedValue,
              onChanged: (val) => setState(() => selectedValue = val!),
              activeColor: Colors.red,
              fillColor: WidgetStateProperty.all(Colors.redAccent),
            ),

            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 200.h,
                  height: 200.h,

                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    border: Border(
                      top: BorderSide(color: Colors.green, width: 4),
                      bottom: BorderSide(color: Colors.red, width: 2),
                      left: BorderSide(color: Colors.blue, width: 3),
                      right: BorderSide(color: Colors.orange, width: 1),
                    ),
                  ),
                ),

                DropdownButton<String>(
                  value: selected, // 👈 current selected value
                  items: options.map((item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selected = value!; // 👈 update selected when changed
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 10),

            //If you want to display a square based on minimum(height, width):
            DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(10.r),
                dashPattern: [15, 2],
                strokeWidth: 3,
                gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 200.r,
                height: 200.r,
              ),
            ),

            SizedBox(height: 10),

            DottedBorder(
              options: CustomPathDottedBorderOptions(
                padding: const EdgeInsets.all(8),
                color: Colors.purple,
                strokeWidth: 2,
                dashPattern: [10, 5],
                customPath: (size) => Path()
                  ..moveTo(0, size.height)
                  ..relativeLineTo(size.width, 0),
              ),
              child: const Text(
                'Custom Path Border',
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            CheckboxListTile(
              title: Text("Accept Terms"),
              value: isChecked,
              onChanged: (val) => setState(() => isChecked = val!),
            ),
            SwitchListTile(
              title: Text("Enable Notifications"),
              value: isOn,
              onChanged: (val) => setState(() => isOn = val),
            ),
            ListTile(
              leading: Radio<int>(
                value: 1,
                groupValue: selectedValue,
                onChanged: (val) => setState(() => selectedValue = val!),
              ),
              title: Text("Option 1"),
            ),
            ListTile(
              leading: Radio<int>(
                value: 2,
                groupValue: selectedValue,
                onChanged: (val) => setState(() => selectedValue = val!),
              ),
              title: Text("Option 2"),
            ),

            SelectableText(
              'Two households, both alike in dignity, In fair Verona, where we lay our scene, From ancient grudge break to new mutiny, Where civil blood makes civil hands unclean. From forth the fatal loins of these two foes',

              // 🔤 Text styling
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                letterSpacing: 0.5,
              ),
              // 👇 Cursor color
              cursorColor: AppColor.red,
              // 🖍️ Selection background color
              selectionColor: AppColor.hamptonColor,
              // 📏 Text alignment
              textAlign: TextAlign.justify,
              // ↕️ Number of lines (optional)
              maxLines: null,
              // 📚 Text direction
              textDirection: TextDirection.ltr,
              // 🔤 Text scaling
              textScaleFactor: 1.0,
              // 🧑‍🦯 Text semantics label (for accessibility)
              semanticsLabel: 'Shakespeare opening lines',
              // 🧭 Toolbar options (copy, select all, etc.)
              // toolbarOptions: const ToolbarOptions(
              //   copy: true,
              //   selectAll: true,
              // ),
              // 🧱 How overflow is handled
              // overflow: TextOverflow.ellipsis, // optional
              // 🧠 StrutStyle (advanced text height control)
              strutStyle: StrutStyle(fontSize: 16, height: 1.5),
              // 🔡 Enable selection
              enableInteractiveSelection: true,
              // 🧬 Focus node (optional)
              // focusNode: FocusNode(),
              // 🎯 Text height behavior (platform text layout control)
              // textHeightBehavior: TextHeightBehavior(...),
              // 🧩 Locale (language support)
              // locale: Locale('en'),
              // 🔠 Text width basis (shrink/expand layout width)
              // textWidthBasis: TextWidthBasis.parent,
            ),
          ],
        ),
      ),
    );
  }
}
