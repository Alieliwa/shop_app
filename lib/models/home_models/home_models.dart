class HomeModel {
  bool? status;
  DataHomeModel? data;
  String? message;

  HomeModel({this.status, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null ? DataHomeModel.fromJson(json["data"]) : null;
  }
}

class DataHomeModel {
  List<BannersModel> banners = [];

  List<ProductsHomeModel> products = [];

  DataHomeModel.fromJson(Map<String, dynamic> json) {
    json["banners"].forEach((element) {
      banners.add(BannersModel.fromJson(element));
    });

    json["products"].forEach((element) {
      products.add(ProductsHomeModel.fromJson(element));
    });
  }
}


class ProductsHomeModel {
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProductsHomeModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    old_price = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    inFavorites = json["in_favorites"];
    inCart = json["in_cart"];
  }
}

class BannersModel {
  int? id;
  String? image;

  BannersModel({
    this.id,
    this.image,
  });

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
  }
}
