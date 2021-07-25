// To parse this JSON data, do
//
//     final categoryApi = categoryApiFromJson(jsonString);

import 'dart:convert';

import 'package:recipe_for_students_flutter/app/models/food.dart';

class RecipeMealApi {
  RecipeMealApi({
    required this.meals,
  });

  List<RecipeMeal> meals;

  static RecipeMealApi parseRecipeMealApi(String responseBody) {
    final parsed = RecipeMealApi.fromRawJson(responseBody);

    return parsed;
  }

  factory RecipeMealApi.fromRawJson(String str) =>
      RecipeMealApi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipeMealApi.fromJson(Map<String, dynamic> json) => RecipeMealApi(
        meals: List<RecipeMeal>.from(
            (json["meals"] ?? []).map((x) => RecipeMeal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class RecipeIngredient {
  RecipeIngredient({
    required this.strIngredient,
    required this.strMeasure,
    required this.strIngredientThumb,
  });

  String strIngredient;
  String strMeasure;
  String strIngredientThumb;
}

class RecipeMeal {
  RecipeMeal({
    required this.idMeal,
    required this.strMeal,
    required this.strDrinkAlternate,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    required this.strTags,
    required this.strYoutube,
    required this.strSource,
    required this.strImageSource,
    required this.strCreativeCommonsConfirmed,
    required this.dateModified,
    required this.ingredients,
  });

  String idMeal;
  String strMeal;
  String? strDrinkAlternate;
  String? strCategory;
  String strArea;
  String strInstructions;
  String strMealThumb;
  String? strTags;
  String strYoutube;
  String strSource;
  String? strImageSource;
  String? strCreativeCommonsConfirmed;
  String? dateModified;
  List<RecipeIngredient> ingredients;

  factory RecipeMeal.fromRawJson(String str) =>
      RecipeMeal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipeMeal.fromJson(Map<String, dynamic> json) {
    List<RecipeIngredient> ingredients = createIngredientList(json);

    return RecipeMeal(
      idMeal: json["idMeal"],
      strMeal: json["strMeal"],
      strDrinkAlternate: json["strDrinkAlternate"],
      strCategory: json["strCategory"],
      strArea: json["strArea"],
      strInstructions: json["strInstructions"],
      strMealThumb: json["strMealThumb"],
      strTags: json["strTags"],
      strYoutube: json["strYoutube"],
      strSource: json["strSource"],
      strImageSource: json["strImageSource"],
      strCreativeCommonsConfirmed: json["strCreativeCommonsConfirmed"],
      dateModified: json["dateModified"],
      ingredients: ingredients,
    );
  }

  static List<RecipeIngredient> createIngredientList(
    Map<String, dynamic> json,
  ) {
    List<RecipeIngredient> ingredients = [];
    if (json["strIngredient1"] != null &&
        json["strIngredient1"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient1"],
        strMeasure: json["strMeasure1"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient1"]}-Small.png',
      ));
    }
    if (json["strIngredient2"] != null &&
        json["strIngredient2"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient2"],
        strMeasure: json["strMeasure2"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient2"]}-Small.png',
      ));
    }
    if (json["strIngredient3"] != null &&
        json["strIngredient3"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient3"],
        strMeasure: json["strMeasure3"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient3"]}-Small.png',
      ));
    }
    if (json["strIngredient4"] != null &&
        json["strIngredient4"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient4"],
        strMeasure: json["strMeasure4"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient4"]}-Small.png',
      ));
    }
    if (json["strIngredient5"] != null &&
        json["strIngredient5"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient5"],
        strMeasure: json["strMeasure5"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient5"]}-Small.png',
      ));
    }
    if (json["strIngredient6"] != null &&
        json["strIngredient6"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient6"],
        strMeasure: json["strMeasure6"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient6"]}-Small.png',
      ));
    }
    if (json["strIngredient7"] != null &&
        json["strIngredient7"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient7"],
        strMeasure: json["strMeasure7"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient7"]}-Small.png',
      ));
    }
    if (json["strIngredient8"] != null &&
        json["strIngredient8"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient8"],
        strMeasure: json["strMeasure8"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient8"]}-Small.png',
      ));
    }
    if (json["strIngredient9"] != null &&
        json["strIngredient9"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient9"],
        strMeasure: json["strMeasure9"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient9"]}-Small.png',
      ));
    }
    if (json["strIngredient10"] != null &&
        json["strIngredient10"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient10"],
        strMeasure: json["strMeasure10"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient10"]}-Small.png',
      ));
    }
    if (json["strIngredient11"] != null &&
        json["strIngredient11"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient11"],
        strMeasure: json["strMeasure11"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient11"]}-Small.png',
      ));
    }
    if (json["strIngredient12"] != null &&
        json["strIngredient12"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient12"],
        strMeasure: json["strMeasure12"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient12"]}-Small.png',
      ));
    }
    if (json["strIngredient13"] != null &&
        json["strIngredient13"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient13"],
        strMeasure: json["strMeasure13"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient13"]}-Small.png',
      ));
    }
    if (json["strIngredient14"] != null &&
        json["strIngredient14"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient14"],
        strMeasure: json["strMeasure14"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient14"]}-Small.png',
      ));
    }
    if (json["strIngredient15"] != null &&
        json["strIngredient15"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient15"],
        strMeasure: json["strMeasure15"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient15"]}-Small.png',
      ));
    }
    if (json["strIngredient16"] != null &&
        json["strIngredient16"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient16"],
        strMeasure: json["strMeasure16"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient16"]}-Small.png',
      ));
    }
    if (json["strIngredient17"] != null &&
        json["strIngredient17"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient17"],
        strMeasure: json["strMeasure17"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient17"]}-Small.png',
      ));
    }
    if (json["strIngredient18"] != null &&
        json["strIngredient18"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient18"],
        strMeasure: json["strMeasure18"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient18"]}-Small.png',
      ));
    }
    if (json["strIngredient19"] != null &&
        json["strIngredient19"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient19"],
        strMeasure: json["strMeasure19"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient19"]}-Small.png',
      ));
    }
    if (json["strIngredient20"] != null &&
        json["strIngredient20"].toString().trim() != "") {
      ingredients.add(RecipeIngredient(
        strIngredient: json["strIngredient20"],
        strMeasure: json["strMeasure20"],
        strIngredientThumb:
            'https://www.themealdb.com/images/ingredients/${json["strIngredient20"]}-Small.png',
      ));
    }
    return ingredients;
  }

  Map<String, dynamic> toJson() => {
        "idMeal": idMeal,
        "strMeal": strMeal,
        "strDrinkAlternate": strDrinkAlternate,
        "strCategory": strCategory,
        "strArea": strArea,
        "strInstructions": strInstructions,
        "strMealThumb": strMealThumb,
        "strTags": strTags,
        "strYoutube": strYoutube,
        "strSource": strSource,
        "strImageSource": strImageSource,
        "strCreativeCommonsConfirmed": strCreativeCommonsConfirmed,
        "dateModified": dateModified,
      };
}
