class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;

 // ShopLoginModel({this.status , this.message , this.data});

  ShopLoginModel.fromJson(Map<String , dynamic > json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']): null ;
  }
}

class UserData {
  int? id;
  String? email;
  String? name;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  // UserData({
  //   this.id,
  //   this.name,
  //   this.email,
  //   this.image,
  //   this.phone,
  //   this.token,
  //   this.points,
  //   this.credit,
  // });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    points = json['points'];
    phone = json['phone'];
    name = json['name'];
    image = json['image'];
    credit = json['credit'];
    token = json['token'];
  }
}
