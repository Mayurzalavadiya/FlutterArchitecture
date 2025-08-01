import 'package:flutter/material.dart';
import 'package:my_first_app/ui/home/store/home_store.dart';
import 'package:my_first_app/values/colors.dart';
import 'package:my_first_app/values/export.dart';

import '../../../../core/db/app_db.dart';
import '../../../../core/locator/locator.dart';
import '../../../../data/model/response/get_cart_data.dart';

class ProductListView extends StatelessWidget {
  final Products product;
  final void Function(Products product)? onTap;
  final bool isEven;
  final int? productIndex;
  final int? CartIndex;

  const ProductListView({
    super.key,
    required this.product,
    this.onTap,
    required this.isEven, this.productIndex, this.CartIndex,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = product.isSelected ? Colors.white : Colors.black;

    return Container(
      decoration: boxDecoration.copyWith(
        color: product.isSelected
            ? isEven
                  ? Colors.black26
                  : AppColor.red.withOpacity(0.5)
            : null,
        /* border: product.isSelected ? Border.all(color: Colors.black,
              width: 1,
              strokeAlign: BorderSide.strokeAlignInside) : null,*/
      ),
      child: ListTile(
        onTap: () => onTap?.call(product),

        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(product.thumbnail ?? ''),
        ),
        title: Text(
          product.title ?? "No title",
          style: TextStyle(color: textColor),
        ),
        subtitle: Text(
          "Qty: ${product.quantity} • ₹${product.price?.toStringAsFixed(2) ?? "0"}",
          style: TextStyle(color: textColor),
        ),
        trailing: Text(
          "₹${product.total?.toStringAsFixed(2) ?? "0"}",
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }
}
