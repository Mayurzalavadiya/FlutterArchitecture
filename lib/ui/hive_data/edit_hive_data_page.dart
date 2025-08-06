  import 'package:auto_route/annotations.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:my_first_app/ui/home/home/widget/product_list.dart';

  import '../../core/db/app_db.dart';
  import '../../data/model/response/get_cart_data.dart';
  import '../../values/colors.dart';
  import '../../values/style.dart';

  @RoutePage()
  class EditHiveDataPage extends StatefulWidget {
    final Products product;

    const EditHiveDataPage({super.key, required this.product});

    @override
    State<EditHiveDataPage> createState() => _EditHiveDataPageState();
  }

  class _EditHiveDataPageState extends State<EditHiveDataPage> {
    List<Products> product = appDB.products;

    @override
    Widget build(BuildContext context) {
      bool isCheck = widget.product.isSelected;

      return Scaffold(
        appBar: AppBar(title: Text("Edit Hive Data Animation")),
        body:ProductListView(
          isEdit: false,
          product: widget.product,
          onTap: (product) {
            // Optional: handle tap
          },
          // isEven: index % 2 == 0,
          isEven: false,
          isCheck: true,
          isLocal: true,
        )

       /* Hero(
          tag: 'hero-animation-${widget.product.title}',
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: boxDecoration.copyWith(
                color: widget.product.isSelected?AppColor.teal.withOpacity(0.5):AppColor.white,
                *//* border: product.isSelected ? Border.all(color: Colors.black,
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignInside) : null,*//*
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 4,
                ),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.product.thumbnail ?? ''),
                ),
                title: Text(
                  widget.product.title ?? "No title",
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  "Qty: ${widget.product.quantity} • ₹${widget.product.price?.toStringAsFixed(2) ?? "0"}",
                  style: TextStyle(color:  Colors.black),
                ),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    SizedBox(width: 8),
                      Checkbox(
                        value: isCheck,
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onChanged: (value) {
                          final index = product.indexOf(widget.product);
                          if (index != -1) {
                            this.product[index].isSelected =
                            !(this.product[index].isSelected ?? false);
                            appDB.products = this.product;
                            setState(() {});
                          }


                          setState(() {
                            widget.product.isSelected = value!;
                          },);
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        )*/
      );
    }
  }
