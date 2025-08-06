import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_first_app/core/db/app_db.dart';

import '../../data/model/response/get_cart_data.dart';
import '../../main.dart';
import '../../router/app_router.dart';
import '../home/home/widget/product_list.dart';

@RoutePage()
class HiveDataPage extends StatefulWidget {
  const HiveDataPage({super.key});

  @override
  State<HiveDataPage> createState() => _HiveDataPageState();
}

class _HiveDataPageState extends State<HiveDataPage>  {
  List<Products> product = appDB.products;

/*

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    _loadProducts();
  }

  void _loadProducts() {
    product = appDB.products;
    setState(() {});
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  // Called when coming back from Edit page
  @override
  void didPopNext() {
    _loadProducts(); // Reload data
  }
*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hive Data")),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: product.length, // ✅ Required!
          itemBuilder: (context, index) {
            return ProductListView(
              isEdit: false,
              product: product[index],
              // isEven: index % 2 == 0,
              isEven: false,
              isLocal: true,
            );
          },
        ),
      ),
    );
  }
}
