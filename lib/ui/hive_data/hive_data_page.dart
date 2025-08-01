import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/core/db/app_db.dart';

import '../../data/model/response/get_cart_data.dart';
import '../home/home/widget/product_list.dart';

@RoutePage()
class HiveDataPage extends StatefulWidget {
  const HiveDataPage({super.key});

  @override
  State<HiveDataPage> createState() => _HiveDataPageState();
}

class _HiveDataPageState extends State<HiveDataPage> {
  List<Products> product = appDB.products;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color: Colors.lightBlue,
        child: ListView.builder(
                itemCount: product.length, // ✅ Required!
                itemBuilder: (context, index) {
                  return ProductListView(
                    product: product[index],
                    onTap: (product) {
                      // Optional: handle tap
                    },
                    isEven: index % 2 == 0,
                  );
                },
              ),
      ),
    );
  }
}
