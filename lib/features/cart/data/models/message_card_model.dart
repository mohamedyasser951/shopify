class ResultCardModel {
  bool? status;
  String? message;
  ResultData? data;

  ResultCardModel({this.status, this.message, this.data});

  ResultCardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ResultData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ResultData {
  num? subTotal;
  num? total;

  ResultData({this.subTotal, this.total});

  ResultData.fromJson(Map<String, dynamic> json) {
    subTotal = json['sub_total'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_total'] = this.subTotal;
    data['total'] = this.total;
    return data;
  }
}