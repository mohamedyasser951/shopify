import 'package:commerceapp/features/home/data/models/home_model.dart';

class FavoriteModel {
  bool? status;
  String? message;
  Data? data;

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json["message"];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<ProductData>? data = [];

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(ProductData.fromJson(v));
      });
    }
  }
}

class ProductData {
  int? id;
  Products? product;

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? Products.fromJson(json['product']) : null;
  }
}

