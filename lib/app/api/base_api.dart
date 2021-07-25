import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:recipe_for_students_flutter/app/api/recipe_category_api.dart';
import 'package:recipe_for_students_flutter/app/api/recipe_filter_api.dart';
import 'package:recipe_for_students_flutter/app/api/recipe_meal_api.dart';

class Api {
  static String baseURL = 'www.themealdb.com';
  static String apiKey = 'api/json/v1/1';
  static String categories = 'categories.php';
  static String random = 'random.php';
  static String categoryFilter = 'filter.php';
  static String search = 'search.php';
  static String lookup = 'lookup.php';
  static Future<RecipeCategoryApi> getCategory<T>() async {
    var endpoint = '${Api.apiKey}/${Api.categories}';
    try {
      http.Response response = await http.get(Uri.https(baseURL, endpoint));
      return await compute(
        RecipeCategoryApi.parseRecipeCategoryApi,
        response.body,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<RecipeMealApi> getRandomMeal<T>() async {
    var endpoint = '${Api.apiKey}/${Api.random}';
    try {
      http.Response response = await http.get(Uri.https(baseURL, endpoint));
      return await compute(
        RecipeMealApi.parseRecipeMealApi,
        response.body,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<RecipeFilterApi> getRecipeByCategoryFilter<T>(
    String categoryTitle,
  ) async {
    var endpoint = '${Api.apiKey}/${Api.categoryFilter}';
    print(Uri.https(baseURL, endpoint));
    try {
      final queryParameters = {
        'c': categoryTitle,
      };
      http.Response response = await http.get(
        Uri.https(baseURL, endpoint, queryParameters),
      );
      return await compute(
        RecipeFilterApi.parseRecipeFilterApi,
        response.body,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<RecipeFilterApi> getRecipeBySearch<T>(
    String search,
  ) async {
    var endpoint = '${Api.apiKey}/${Api.search}';
    print(Uri.https(baseURL, endpoint));
    try {
      final queryParameters = {
        's': search,
      };
      http.Response response = await http.get(
        Uri.https(baseURL, endpoint, queryParameters),
      );
      return await compute(
        RecipeFilterApi.parseRecipeFilterApi,
        response.body,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<RecipeMealApi> getRecipeById<T>(
    String id,
  ) async {
    var endpoint = '${Api.apiKey}/${Api.lookup}';
    try {
      final queryParameters = {
        'i': id,
      };
      http.Response response = await http.get(
        Uri.https(baseURL, endpoint, queryParameters),
      );
      return await compute(
        RecipeMealApi.parseRecipeMealApi,
        response.body,
      );
    } catch (e) {
      rethrow;
    }
  }
  // ?i=52772
}

class ApiProvider extends ChangeNotifier {
  RecipeCategoryApi? _recipeCategoryApi;
  RecipeMealApi? _recipeRandomMealApi;
  RecipeFilterApi? _recipeFilterApi;
  RecipeMealApi? _recipeMealLookUpApi;

  Future<RecipeCategoryApi> getCategory() async {
    _recipeCategoryApi ??= await Api.getCategory();
    return _recipeCategoryApi!;
  }

  Future<RecipeMealApi> getRandomMeal() async {
    _recipeRandomMealApi ??= await Api.getRandomMeal();
    return _recipeRandomMealApi!;
  }

  String? categoryTitleFilter;
  Future<RecipeFilterApi> getRecipeByCategoryFilter(
      String categoryTitle) async {
    if (_recipeFilterApi == null) {
      _recipeFilterApi = await Api.getRecipeByCategoryFilter(categoryTitle);
    } else if (categoryTitleFilter != null &&
        categoryTitleFilter != categoryTitle) {
      _recipeFilterApi = await Api.getRecipeByCategoryFilter(categoryTitle);
    }
    categoryTitleFilter = categoryTitle;
    return _recipeFilterApi!;
  }

  String? searchTerm;
  Future<RecipeFilterApi> getRecipeBySearch(String search) async {
    if (_recipeFilterApi == null) {
      _recipeFilterApi = await Api.getRecipeBySearch(search);
    } else if (searchTerm != null && searchTerm != search) {
      _recipeFilterApi = await Api.getRecipeBySearch(search);
    }
    searchTerm = search;
    return _recipeFilterApi!;
  }

  String? lastId;
  Future<RecipeMealApi> getRecipeById(
    String id,
  ) async {
    if (lastId != null && id == lastId && _recipeMealLookUpApi != null) {
      return _recipeMealLookUpApi!;
    }
    _recipeMealLookUpApi = await Api.getRecipeById(id);
    lastId = id;
    return _recipeMealLookUpApi!;
  }
}

final apiProvider = ApiProvider();
