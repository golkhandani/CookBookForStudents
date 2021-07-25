// To parse this JSON data, do
//
//     final recipeFilterApi = recipeFilterApiFromJson(jsonString);

import 'dart:convert';

class RecipeFilterApi {
  RecipeFilterApi({
    required this.meals,
  });

  List<RecipeMealFilter> meals;

  static RecipeFilterApi parseRecipeFilterApi(String responseBody) {
    final parsed = RecipeFilterApi.fromRawJson(responseBody);
    return parsed;
  }

  factory RecipeFilterApi.fromRawJson(String str) =>
      RecipeFilterApi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipeFilterApi.fromJson(Map<String, dynamic> json) =>
      RecipeFilterApi(
        meals: List<RecipeMealFilter>.from(
            (json["meals"] ?? []).map((x) => RecipeMealFilter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class RecipeMealFilter {
  RecipeMealFilter({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  String strMeal;
  String strMealThumb;
  String idMeal;

  factory RecipeMealFilter.fromRawJson(String str) =>
      RecipeMealFilter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipeMealFilter.fromJson(Map<String, dynamic> json) =>
      RecipeMealFilter(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
      );

  Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
      };
}
