
import 'package:hive/hive.dart';

part 'get_cart_data.g.dart';

class GetCartData {
  List<Carts>? carts;
  int? total;
  int? skip;
  int? limit;

  GetCartData({this.carts, this.total, this.skip, this.limit});

  GetCartData.fromJson(Map<String, dynamic> json) {
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) {
        carts!.add(new Carts.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.carts != null) {
      data['carts'] = this.carts!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }
}

class Carts {
  int? id;
  List<Products>? products;
  double? total;
  double? discountedTotal;
  int? userId;
  int? totalProducts;
  int? totalQuantity;

  Carts({
    this.id,
    this.products,
    this.total,
    this.discountedTotal,
    this.userId,
    this.totalProducts,
    this.totalQuantity,
  });

  Carts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    total = json['total'];
    discountedTotal = json['discountedTotal'];
    userId = json['userId'];
    totalProducts = json['totalProducts'];
    totalQuantity = json['totalQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['discountedTotal'] = this.discountedTotal;
    data['userId'] = this.userId;
    data['totalProducts'] = this.totalProducts;
    data['totalQuantity'] = this.totalQuantity;
    return data;
  }
}

@HiveType(typeId: 2)
class Products {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  double? price;
  @HiveField(3)
  int? quantity;
  @HiveField(4)
  bool isSelected = false;
  @HiveField(5)
  double? total;
  @HiveField(6)
  double? discountPercentage;
  @HiveField(7)
  double? discountedTotal;
  @HiveField(8)
  String? thumbnail;

  Products({
    this.id,
    this.title,
    this.price,
    this.quantity,
    this.isSelected = false,
    this.total,
    this.discountPercentage,
    this.discountedTotal,
    this.thumbnail,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = toDouble(json['price']);
    quantity = toInt(json['quantity']);
    isSelected = json['isSelected'] ?? false;
    total = toDouble(json['total']);
    discountPercentage = toDouble(json['discountPercentage']);
    discountedTotal = toDouble(json['discountedTotal']);
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['isSelected'] = this.isSelected;
    data['total'] = this.total;
    data['discountPercentage'] = this.discountPercentage;
    data['discountedTotal'] = this.discountedTotal;
    data['thumbnail'] = this.thumbnail;
    return data;
  }

  Products copyWith({
    int? id,
    String? title,
    double? price,
    int? quantity,
    double? total,
    double? discountPercentage,
    double? discountedTotal,
    String? thumbnail,
    bool? isSelected,
  }) {
    return Products(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountedTotal: discountedTotal ?? this.discountedTotal,
      thumbnail: thumbnail ?? this.thumbnail,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}



double? toDouble(dynamic val) {
  if (val == null) return null;
  return val is int ? val.toDouble() : val;
}

int? toInt(dynamic val) {
  if (val == null) return null;
  return val is double ? val.toInt() : val;
}

