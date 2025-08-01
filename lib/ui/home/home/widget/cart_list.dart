import 'package:flutter/material.dart';
import 'package:my_first_app/ui/home/home/widget/product_list.dart';
import 'package:my_first_app/ui/home/store/home_store.dart';
import 'package:my_first_app/values/export.dart';
import 'package:my_first_app/widget/show_message.dart';
import '../../../../data/model/response/get_cart_data.dart';

class CartListView extends StatelessWidget {
  final Carts cart;
  final void Function(Products product)? onProductTap;
  final void Function(Carts cart)? onCartTap;
  final int index;

  const CartListView({
    super.key,
    required this.cart,
    this.onCartTap,
    this.onProductTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {



    return GestureDetector(
      onTap: () => onCartTap?.call(cart),
      child: Card(
        margin: EdgeInsets.all(12),
        elevation: 4,
        color: AppColor.calico,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 0,
                top: 12,
                left: 12,
                right: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'User ID : ',
                          style: textBold.copyWith(color: AppColor.black),
                          children: [
                            TextSpan(
                              text: '${cart.userId}',
                              style: textRegular,
                            ),
                          ],
                        ),
                      ),

                      RichText(
                        text: TextSpan(
                          text: 'Total Products : ',
                          style: textBold.copyWith(color: AppColor.black),
                          children: [
                            TextSpan(
                              text: '${cart.totalProducts}',
                              style: textRegular,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Quantity: ${cart.totalQuantity}"),
                      Text(
                        "Cart Total: ₹${cart.total?.toStringAsFixed(2) ?? "0"}",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.transparent),

            /// Inner product list
            Container(
              decoration: BoxDecoration(
                color: index % 2 == 0
                    ? AppColor.red.withOpacity(0.7)
                    : AppColor.lightBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cart.products?.length ?? 0,
                  itemBuilder: (context, index) {
                    final product = cart.products![index];
                    return Dismissible(
                      key: Key(cart.id?.toString() ?? index.toString()),

                      direction: DismissDirection.horizontal,

                      background: slideRightBackground(),
                      secondaryBackground: slideLeftBackground(),

                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          // Swipe left to delete
                          final confirm = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Delete Cart?'),
                              content: Text(
                                'Are you sure you want to delete this cart?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                    homeStore.removeProductFromCart(
                                      this.index,
                                      index,
                                    );
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          );
                          return confirm;
                        } else if (direction == DismissDirection.startToEnd) {
                          // Swipe right to edit
                          showCustomToast(
                            context,
                            message: "Edit cart ${cart.id}",
                          );
                          return false; // Do not dismiss
                        }
                        return false;
                      },

                      child: ProductListView(
                        product: product,
                        onTap: onProductTap,
                        isEven: this.index % 2 == 0,
                        CartIndex: this.index,
                        productIndex: index,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 20),
            Icon(Icons.edit, color: Colors.white),
            Text(
              " Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.delete, color: Colors.white),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
