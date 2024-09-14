class CartModel {
  bool? status;
  CardData? data;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? CardData.fromJson(json['data']) : null;
  }
}

class CardData {
  List<CartItems>? cartItems;
  num? subTotal;
  num? total;
  CardData({
  required  this.cartItems,
  required  this.subTotal,
  required  this.total,
  });

  CardData.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class CartItems {
  int? id;
  num? quantity;
  ProductCard? product;

  CartItems({this.id, this.quantity, this.product});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? ProductCard.fromJson(json['product']) : null;
  }
}
class ProductCard {
  int? id;
  num? price;
  num? oldPrice;
  num? discount;
  String? image;
  String? name;
  String? description;

  ProductCard(
      {this.id,
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.name,
      this.description});

  ProductCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}