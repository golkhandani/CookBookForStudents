// To parse this JSON data, do
//
//     final categoryApi = categoryApiFromJson(jsonString);

import 'dart:convert';

class RecipeCategoryApi {
  RecipeCategoryApi({
    required this.categories,
  });

  List<RecipeCategory> categories;

  static RecipeCategoryApi parseRecipeCategoryApi(String responseBody) {
    final parsed = RecipeCategoryApi.fromRawJson(responseBody);

    return parsed;
  }

  factory RecipeCategoryApi.fromRawJson(String str) =>
      RecipeCategoryApi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipeCategoryApi.fromJson(Map<String, dynamic> json) =>
      RecipeCategoryApi(
        categories: List<RecipeCategory>.from(
            json["categories"].map((x) => RecipeCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class RecipeCategory {
  RecipeCategory({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  String idCategory;
  String strCategory;
  String strCategoryThumb;
  String strCategoryDescription;

  factory RecipeCategory.fromRawJson(String str) =>
      RecipeCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipeCategory.fromJson(Map<String, dynamic> json) => RecipeCategory(
        idCategory: json["idCategory"],
        strCategory: json["strCategory"],
        strCategoryThumb: json["strCategoryThumb"],
        strCategoryDescription: json["strCategoryDescription"],
      );

  Map<String, dynamic> toJson() => {
        "idCategory": idCategory,
        "strCategory": strCategory,
        "strCategoryThumb": strCategoryThumb,
        "strCategoryDescription": strCategoryDescription,
      };
}
