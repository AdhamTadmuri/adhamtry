import 'dart:convert';

class MealModel {
  int? id;
  String? name;
  String? categoryName;
  int? price;
  int? categoryId;
  String? description;
  List<String>? images;

  MealModel(
      {this.id,
      this.name,
      this.categoryName,
      this.price,
      this.categoryId,
      this.description,
      this.images});

  MealModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryName = json['categoryName'];
    price = json['price'];
    categoryId = json['categoryId'];
    description = json['description'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['categoryName'] = this.categoryName;
    data['price'] = this.price;
    data['categoryId'] = this.categoryId;
    data['description'] = this.description;
    data['images'] = this.images;
    return data;
  }

  // static Map<String, dynamic> toMap(MealModel model) {
  //   return {
  //     "name": model.name,
  //     "categoryName": model.categoryName,
  //     "meal_model": model.mealModel,
  //   };
  // }

  // static String encode(List<MealModel> list) => json.encode(
  //       list
  //           .map<Map<String, dynamic>>((element) => MealModel.toMap(element))
  //           .toList(),
  //     );

  // static List<MealModel> decode(String strList) =>
  //     (json.decode(strList) as List<dynamic>)
  //         .map<MealModel>((item) => MealModel.fromJson(item))
  //         .toList();
}
