class CategoriesModel {
  bool? status;
  String? message;
  CategoriesDataModel? data;

  CategoriesModel({this.status, this.message, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null
        ? CategoriesDataModel.fromJson(json["data"])
        : null;
  }
}

class CategoriesDataModel {
  int? current_page;
  List<DataCategoriesModels> data = [];

  CategoriesDataModel({this.current_page, required this.data});

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    current_page = json["current_page"];
    json["data"].forEach((element) {
      data.add(DataCategoriesModels.fromJson(element));
    });
  }
}

class DataCategoriesModels {
  int? id;
  String? name;
  String? image;

  DataCategoriesModels({this.id, this.name, this.image});

  DataCategoriesModels.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
}

