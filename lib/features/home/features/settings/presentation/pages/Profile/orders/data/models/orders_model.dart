// {
//     "status": true,
//     "message": null,
//     "data": {
//         "current_page": 1,
//         "data": [
//             {
//                 "id": 3531,
//                 "total": 0,
//                 "date": "22 / 08 / 2023",
//                 "status": "جديد"
//             },
//             {
//                 "id": 3530,
//                 "total": 0,
//                 "date": "22 / 08 / 2023",
//                 "status": "جديد"
//             },
//             {
//                 "id": 3529,
//                 "total": 0,
//                 "date": "22 / 08 / 2023",
//                 "status": "جديد"
//             },
//             {
//                 "id": 3526,
//                 "total": 19491.72000000000116415321826934814453125,
//                 "date": "21 / 08 / 2023",
//                 "status": "جديد"
//             },
//             {
//                 "id": 3525,
//                 "total": 0,
//                 "date": "18 / 08 / 2023",
//                 "status": "ملغي"
//             }
//         ],
//         "first_page_url": "https://student.valuxapps.com/api/orders?page=1",
//         "from": 1,
//         "last_page": 1,
//         "last_page_url": "https://student.valuxapps.com/api/orders?page=1",
//         "next_page_url": null,
//         "path": "https://student.valuxapps.com/api/orders",
//         "per_page": 35,
//         "prev_page_url": null,
//         "to": 5,
//         "total": 5
//     }
// }

class OrdersModel {
  bool? status;
  OrdersData? data;

  OrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? OrdersData.fromJson(json['data']) : null;
  }
}

class OrdersData {
  List<OrderData>? data;

  OrdersData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(OrderData.fromJson(v));
      });
    }
  }
}

class OrderData {
  int? id;
  num? total;
  String? date;
  String? status;

  OrderData({this.id, this.total, this.date, this.status});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    date = json['date'];
    status = json['status'];
  }
}
