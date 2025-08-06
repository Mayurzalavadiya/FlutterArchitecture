import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as badges;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:my_first_app/core/db/app_db.dart';
import 'package:my_first_app/router/app_router.dart';
import 'package:my_first_app/ui/home/home/widget/cart_list.dart';
import 'package:my_first_app/ui/home/store/home_store.dart';
import 'package:my_first_app/widget/base_app_bar.dart';
import 'package:my_first_app/widget/loading_widget.dart';

import '../../../core/locator/locator.dart';
import '../../../data/model/response/get_cart_data.dart';
import '../../../utils/analytics.dart';
import '../../../values/colors.dart';
import '../../../widget/show_message.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  final VoidCallback? onSwitchToWidgets;
  final int? notificationCount;

  const HomePage({
    super.key,
    required this.onSwitchToWidgets,
    required this.notificationCount,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool showLoading;
  final ScrollController _scrollController = ScrollController();
  List<ReactionDisposer>? _disposers;


  @override
  void initState() {
    super.initState();
    AnalyticsService().logScreenView("HomeScreen");

    showLoading = true;
    fetchData();
    _scrollController.addListener(() {
      // showMessage('Scroll position: ${_scrollController.position}');
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
        showCustomToast(
          textColor: AppColor.white,
          context,
          // backgroundColor: AppColor.red.withOpacity(0.5),
          message: "Reached end",
          border: Border.all(
            strokeAlign: BorderSide.strokeAlignInside,
            width: 2,
            color: AppColor.teal,
          ),
          gradient: LinearGradient(colors: [Colors.red, Colors.black38]),
        );
      }
    });

    debugPrint("FCM Token: ${appDB.fcmToken}");

    addDisposer();
  }

  void addDisposer() {
    _disposers ??= [
      // success reaction
      reaction((_) => homeStore.cartResponse, (response) {
        if (response?.code == "200") {
          showLoading = false;
          showMessage(response?.message ?? "");
        } else{
          showLoading = false;
        }
      }),
      // error reaction
      reaction((_) => homeStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          showLoading = false;
          showCustomToast(context, message: errorMessage);
        }
      }),
    ];
  }

  void fetchData() async {
    await homeStore.getCartData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      body: Observer(
        builder: (_) {
          return LoadingWidget(status: showLoading, child: cartList());
        },
      ),
    );
  }

  PreferredSizeWidget mainAppBar() {
    return BaseAppBar(
      showTitle: true,
      centerTitle: false,
      title: "Cart Products",
      backgroundColor: AppColor.teal,
      leadingIcon: true,
      action: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            if (kDebugMode) {
              print("Search clicked");
            }
          },
        ),
        badges.Badge(
          showBadge: (widget.notificationCount ?? 0) > 0,
          badgeContent: Text(
            widget.notificationCount != null && widget.notificationCount! > 99
                ? '99+'
                : '${widget.notificationCount ?? 0}',
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),

          position: badges.BadgePosition.topEnd(top: 2, end: 5),
          child: IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              showCustomToast(context, message: "notification");
              showCustomSnackBar(
                context,
                message: "Saved successfully!",
                backgroundColor: Colors.green,
              );
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            context.router.replaceAll([BottomNavRoute()]);
          },
          /* Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const BottomNavPage()),
              (route) => false, // Remove all routes
            );
          },*/
        ),
      ],

      backAction:
          (widget.notificationCount == null || widget.notificationCount == 0)
          ? null
          : () {
              showMessage("back click");
              widget.onSwitchToWidgets?.call();
            },
    );
  }

  Widget cartList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: homeStore.cartsList.length,
      itemBuilder: (context, index) {
        return CartListView(
          index: index,
          cart: homeStore.cartsList[index],
          onCartTap: (cart) {
            final id = cart.id ?? "N/A";
            final name = cart.userId ?? "Unknown";
            showMessage("Clicked Cart: $name (ID: $id)");
          },
          onProductTap: (product) {
            setState(() {
              product.isSelected = !product.isSelected; // Toggle selection
            });
            final currentList = appDB.products;

            // Add or remove the product
            if (currentList.contains(product)) {
              currentList.remove(product);
            } else {
              currentList.add(product);
            }

            // Save updated list back to Hive
            appDB.products = List.from(currentList);

            final id = product.id ?? "N/A";
            final name = product.title ?? "Unknown";
            // showCustomToast(context, message: "$name (ID: $id)");
          },
        );
      },
    );
  }
}

/*Widget cartListView(List<Cart> cartListData) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue, width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: cartListData.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text('Item #$index'),
          subtitle: Text('Subtitle for item #$index'),
          trailing: Icon(Icons.person),
          onTap: () {
            showMessage('Tapped item #$index');
            showCustomToast(
              context,
              message: 'Tapped item #$index',
              backgroundColor: AppColor.primaryColor,
              gravity: ToastGravity.TOP,
              textColor: AppColor.white,
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    ),
  );
}*/
