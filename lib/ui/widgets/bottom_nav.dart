import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_first_app/core/db/app_db.dart';
import 'package:my_first_app/core/db/share_pref.dart';
import 'package:my_first_app/router/app_router.dart';
import 'package:my_first_app/ui/animation/animated_container_page.dart';
import 'package:my_first_app/ui/auth/login_page.dart';
import 'package:my_first_app/ui/editProfile/image_video_picker_page.dart';
import 'package:my_first_app/ui/quotes/quptes_page.dart';
import 'package:my_first_app/ui/widgets/widgets_page.dart';
import 'package:my_first_app/widget/show_message.dart';

import '../../core/locator/locator.dart';
import '../../utils/notification_service.dart';
import '../../utils/permissions.dart';
import '../../values/colors.dart';
import '../hive_data/hive_data_page.dart';
import '../home/home/home_page.dart';

@RoutePage()
class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int selectedIndex = 0;
  int cartCount = 0;
  int notificationCount = 0;
  final String image =
      'https://images.unsplash.com/photo-1518495973542-4542c06a5843?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

  final appDB = locator.get<AppDB>();

  @override
  void initState() {
    super.initState();

    // Request notification permission only after login
    Permissions.requestNotificationPermission(context).then((granted) {
      if (granted) {
        debugPrint("✅ FCM token: ${appDB.fcmToken}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List pages = [
      WidgetsPage(),
      HomePage(
        onSwitchToWidgets: () {
          setState(() {
            selectedIndex = 0;
            cartCount++;
            showMessage("index 0");
          });
        },
        notificationCount: notificationCount,
      ),
      QuotesPage(),
      LoginPage(),
      ImageVideoPickerPage(),
    ];

    void onDrawerItemTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
      Navigator.pop(context);
      // Navigate if needed based on index...
    }

    return PopScope(
      canPop: false,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          appBar: AppBar(title: Text('${appPreferences.user?.name}')),
          drawer: SafeArea(
            child: Drawer(
              // 👈 Drawer added here
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle.light.copyWith(
                      statusBarColor: Colors.deepPurple,
                      // 🎯 Only drawer visible area
                      statusBarIconBrightness: Brightness.light,
                    ),
                    child: UserAccountsDrawerHeader(
                      accountName: Text('${appPreferences.user?.name}'),
                      accountEmail: Text('${appPreferences.user?.email}'),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(
                          '${appPreferences.user?.profileImage}',
                        ),
                      ),
                    ),
                  ),
                  /* DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text(
                    'Welcome!',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),*/
                  ExpansionTile(
                    leading: Icon(Icons.design_services),
                    title: Text('Figma Design'),
                    children: [
                      ListTile(
                        leading: Icon(Icons.looks_one),
                        title: Text('Figma 1'),
                        onTap: () {
                          Navigator.pop(context);
                          context.router.push(FigmaSplashRoute());
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.looks_two),
                        title: Text('Figma 2'),
                        onTap: () {
                          Navigator.pop(context);
                          context.router.push(MoodyRoute());
                        },
                      ),
                    ],
                  ),


                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Widgets'),
                    selected: selectedIndex == 0,
                    selectedTileColor: Colors.deepPurple.shade100,
                    // set selected bg color
                    onTap: () => onDrawerItemTapped(0),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Home'),
                    selected: selectedIndex == 1,
                    selectedTileColor: Colors.deepPurple.shade100,
                    onTap: () => onDrawerItemTapped(1),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Provider'),
                    selected: selectedIndex == 8,
                    selectedTileColor: Colors.deepPurple.shade100,
                    onTap: () {
                      /*setState(() {
                        selectedDrawerIndex = 2;
                      });*/
                      Navigator.pop(context);
                      context.router.push(ProviderRoute());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.search),
                    title: Text('Search'),
                    selected: selectedIndex == 2,
                    selectedTileColor: Colors.deepPurple.shade100,
                    onTap: () => onDrawerItemTapped(2),
                  ),
                 /* ListTile(
                    leading: Icon(Icons.search),
                    title: Text('Hive Data'),
                    selected: selectedIndex == 5,
                    selectedTileColor: Colors.deepPurple.shade100,
                    onTap: () {
                      setState(() {
                        selectedIndex = 5;
                      });
                      Navigator.pop(context);
                    },
                  ),*/

                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Animated Container'),
                    onTap: () {
                      Navigator.pop(context);
                      context.router.push(AnimatedContainerRoute());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Tween Animation'),
                    onTap: () {
                      Navigator.pop(context);
                      context.router.push(TweenAnimationRoute());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Hero Animation'),
                    onTap: () {
                      Navigator.pop(context);
                      context.router.push(HeroAnimationRoute());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.data_object_sharp),
                    title: Text('Hive Data'),
                    onTap: () {
                      Navigator.pop(context);
                      context.router.push(HiveDataRoute());

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.data_object_sharp),
                    title: Text('List'),
                    onTap: () {
                      Navigator.pop(context);
                      context.router.push(ListRoute());

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('LogOut'),
                    selected: selectedIndex == 8,
                    selectedTileColor: Colors.deepPurple.shade100,
                    onTap: () {
                      Navigator.pop(context);
                      confirm();
                    },
                  ),
                ],
              ),
            ),
          ),
          body: pages[selectedIndex],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,

          //Different types of Animation

          // transition (grow/shrink)
          /*  floatingActionButton: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return SizeTransition(
              sizeFactor: animation,
              axis: Axis.vertical,
              child: child,
            );
          },
          child: _buildFloatingActionButton(),
        ),*/

          //    Rotation (flip)
          /* floatingActionButton: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: Tween<double>(begin: 0.75, end: 1.0).animate(animation),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: _buildFloatingActionButton(),
        ),*/
          // slid Animation
          /*floatingActionButton: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation);

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: offsetAnimation,
                child: child,
              ),
            );
          },
          child: _buildFloatingActionButton(),
        ),*/
          floatingActionButton: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child:
                _buildFloatingActionButton(), // Dynamically returns FAB or null
          ),

          //Normal button
          /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (selectedIndex != 1) {
                notificationCount++;
              }
              selectedIndex = 1;
            });
          },
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Icon(Icons.home_filled, color: AppColor.white),
        ),*/
          /* floatingActionButton:  FloatingActionButton.extended(
              onPressed: () {},
              icon: Icon(Icons.upload),
              label: Text("Upload"),
            ),*/

          /*   bottomNavigationBar: BottomAppBar(
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.home),
                    color: Colors.white,
                    onPressed: () => showMessage("home"),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings),
                    color: Colors.white,
                    onPressed: () => showMessage("settings"),
                  ),
                ],
              ),
            ),*/
          /* bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedIndex, // 🧠 selected tab
              type: BottomNavigationBarType.shifting,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black54,
              onTap: (int index) {
                setState(() {
                  selectedIndex = index; // 🔁 update UI when clicked
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.blue,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                  backgroundColor: Colors.red,
                ),
              ],
            ),*/
          /* bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColor.white,
          unselectedItemColor: AppColor.black,
          backgroundColor: Colors.blue,
          currentIndex: selectedIndex,
          onTap: (index) => setState(() => selectedIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Widgets'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          ],
        ),*/
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColor.teal,
            selectedItemColor: AppColor.white,
            unselectedItemColor: AppColor.black,
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                if (index != selectedIndex) {
                  if (index == 0) {
                    cartCount++;
                  } else if (index == 1) {
                    notificationCount++;
                  }
                  /* else if (index == 3) {
                    appPreferences.isLogin = false;
                  } */
                  else {
                    cartCount = 0;
                    notificationCount = 0;
                  }
                }
                selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: badges.Badge(
                  showBadge: cartCount > 0,
                  badgeContent: Text(
                    cartCount.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  child: Icon(Icons.person),
                ),
                label: 'Widgets',
              ),
              BottomNavigationBarItem(
                icon: badges.Badge(
                  showBadge: notificationCount > 0,
                  badgeContent: Text(
                    notificationCount.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  child: Icon(Icons.home),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Login'),
              BottomNavigationBarItem(
                icon: Icon(Icons.ac_unit_rounded),
                label: 'Image Picker',
              ),
             /* BottomNavigationBarItem(
                icon: Icon(Icons.data_object_sharp),
                label: 'DataBase',
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  Future confirm() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('LogOut'),
        content: Text('Are you sure you want to LogOut?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              context.router.replaceAll([LoginRoute()]);
              appDB.isLogin = false;
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  Widget? _buildFloatingActionButton() {
    if (selectedIndex == 3 || selectedIndex == 2 || selectedIndex == 4)
      return null;

    return FloatingActionButton(
      key: Key('Home'),
      onPressed: () {
        setState(() {
          if (selectedIndex != 1) {
            notificationCount++;
          }
          selectedIndex = 1;
        });
      },
      backgroundColor: Colors.teal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Icon(Icons.home_filled, color: AppColor.white),
    );
  }
}
