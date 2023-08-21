class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  dynamic points;
  dynamic credit;
  String? token;

  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        image: json['image'] as String?,
        points: json['points'],
        credit: json['credit'],
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'image': image,
        'points': points,
        'credit': credit,
        'token': token,
      };
}
