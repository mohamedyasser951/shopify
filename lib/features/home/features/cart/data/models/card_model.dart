
import 'package:commerceapp/features/home/data/models/home_model.dart';

class CardModel {
  bool? status;
  CardData? data;


  CardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  CardData.fromJson(json['data']) : null;
  }


}

class CardData {
  List<CartItems>? cartItems;
  int? subTotal;
  int? total;


  CardData.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add( CartItems.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }


}

class CartItems {
  int? id;
  num? quantity;
  Products? product;

  CartItems({this.id, this.quantity, this.product});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
        json['product'] != null ?  Products.fromJson(json['product']) : null;
  }


}

