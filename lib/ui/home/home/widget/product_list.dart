
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/values/export.dart';

import '../../../../data/model/response/get_cart_data.dart';
import '../../../../router/app_router.dart';

class ProductListView extends StatelessWidget {
  final Products product;
  final void Function(Products product)? onTap;
  final void Function(Products product)? onCheck;
  final void Function(Products product)? onEdit;
  final bool isEven;
  final int? productIndex;
  final int? CartIndex;
  final bool isEdit;
  final bool isLocal;
  final bool isCheck;

  const ProductListView({
    super.key,
    required this.product,
    this.onTap,
    required this.isEven,
    this.productIndex,
    this.CartIndex,
    this.isEdit = false,
    this.onCheck,
    this.onEdit,
    this.isLocal = false,
    this.isCheck = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = product.isSelected ? Colors.black : Colors.black;
    bool isCheck = product.isSelected ;

    return Hero(
      tag: 'product-${product.id}',
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        // must match with destination
        child: Material(
          // wrap in Material for smoother animation
          color: Colors.transparent,
          child: Container(
            decoration: boxDecoration.copyWith(
              color: product.isSelected
                  ? isLocal
                        ? Colors.teal.withSafeOpacity(0.5)
                        : isEven
                        ? Colors.black26
                        : AppColor.red.withSafeOpacity(0.5)
                  : null,
            ),
            child: ListTile(
              onTap: () => onTap?.call(product),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 4,
              ),
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "₹${product.total?.toStringAsFixed(2) ?? "0"}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  SizedBox(width: 8),
                  if (isCheck)
                    Checkbox(
                      value: isCheck,
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onChanged: (value) {
                        onCheck?.call(product);
                      },
                    ),
                  if (isEdit) ...[
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.black),
                      onPressed: () {
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {},
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
