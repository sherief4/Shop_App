class FavouritesModel {
  late bool status;
  late Data data;



  FavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data =Data.fromJson(json['data']);
  }

}

class Data {
  int? currentPage;
  List<FavouritesData> data = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;


  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(FavouritesData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];

    to = json['to'];
    total = json['total'];
  }

}

class FavouritesData {
  int? id;
  Product? product;

  FavouritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] = Product.fromJson(json['product']);
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}