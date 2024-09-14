// {
//     "status": true,
//     "message": null,
//     "data": {
//         "id": 3525,
//         "cost": 0,
//         "discount": 0,
//         "points": 0,
//         "vat": 0,
//         "total": 0,
//         "points_commission": 0,
//         "promo_code": "----",
//         "payment_method": "نقدا",
//         "date": "18 / 08 / 2023",
//         "status": "ملغي",
//         "address": {
//             "id": 35,
//             "name": "none",
//             "city": "Qanter El kheriea",
//             "region": "USA",
//             "details": "mfmbmf",
//             "notes": "kmpf",
//             "latitude": 0,
//             "longitude": 0
//         },
//         "products": []
//     }
// }

class OrdersDetailsModel {
  bool? status;
  String? message;
  OrdersDetailsData? data;

  OrdersDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json["message"];
    data =
        json['data'] != null ? OrdersDetailsData.fromJson(json['data']) : null;
  }
}

class OrdersDetailsData {
  int? id;
  int? cost;
  int? discount;
  int? points;
  int? vat;
  int? total;
  int? pointsCommission;
  String? promoCode;
  String? paymentMethod;
  String? date;
  String? status;
  Address? address;
  List<dynamic>? products;

  OrdersDetailsData(
      {id,
      cost,
      discount,
      points,
      vat,
      total,
      pointsCommission,
      promoCode,
      paymentMethod,
      date,
      status,
      address,
      products});

  OrdersDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cost = json['cost'];
    discount = json['discount'];
    points = json['points'];
    vat = json['vat'];
    total = json['total'];
    pointsCommission = json['points_commission'];
    promoCode = json['promo_code'];
    paymentMethod = json['payment_method'];
    date = json['date'];
    status = json['status'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['products'] != null) {
      products = <Null>[];
      json['products'].forEach((v) {
        products!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cost'] = cost;
    data['discount'] = discount;
    data['points'] = points;
    data['vat'] = vat;
    data['total'] = total;
    data['points_commission'] = pointsCommission;
    data['promo_code'] = promoCode;
    data['payment_method'] = paymentMethod;
    data['date'] = date;
    data['status'] = status;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  int? id;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  int? latitude;
  int? longitude;

  Address({id, name, city, region, details, notes, latitude, longitude});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['city'] = city;
    data['region'] = region;
    data['details'] = details;
    data['notes'] = notes;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
