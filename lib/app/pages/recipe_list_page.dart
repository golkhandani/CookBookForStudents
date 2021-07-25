import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:recipe_for_students_flutter/app/api/base_api.dart';
import 'package:recipe_for_students_flutter/app/api/recipe_category_api.dart';
import 'package:recipe_for_students_flutter/app/api/recipe_filter_api.dart';
import 'package:recipe_for_students_flutter/app/api/recipe_meal_api.dart';
import 'package:recipe_for_students_flutter/app/models/food.dart';
import 'package:recipe_for_students_flutter/app/notifiers/constant.dart';
import 'package:recipe_for_students_flutter/app/notifiers/theme.dart';
import 'package:recipe_for_students_flutter/app/pages/recipe_meal_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:recipe_for_students_flutter/app/pages/recipe_result_list_page.dart';

class RecipeListPage extends StatefulWidget {
  const RecipeListPage({Key? key}) : super(key: key);
  static String path = 'RecipeListPage';

  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  FocusNode textFieldFocusNode = FocusNode();
  Future fetchCategoryData() async {
    var categoryData = await apiProvider.getCategory();
    return categoryData.categories;
  }

  Future<RecipeMeal> getRandomMeal() async {
    var data = await apiProvider.getRandomMeal();
    return data.meals[0];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appTheme.recipePageBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /** Search bar */
          buildSearchBar(),
          /** Category Intro */
          buildCategoryTitle(),
          /** Category List */
          buildCategoryCardList(),
          /** Surprise */
          buildSurpriseTitle(),
          /** Single Card */
          buildSurpriseCard(),
          /** Gap for navigation list */
          kBottomGap
        ],
      ),
    );
  }

  Container buildSearchBar() {
    return Container(
      margin: const EdgeInsets.only(
        top: kLargeSize,
        left: kLargeSize,
        right: kLargeSize,
      ),
      child: SearchBar(
        textFieldFocusNode: textFieldFocusNode,
        color: appTheme.recipePageSearch,
      ),
    );
  }

  Container buildCategoryTitle() {
    return Container(
      margin: const EdgeInsets.only(
        top: kLargeSize,
        left: kLargeSize,
        right: kLargeSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kCategoryTitle,
            style: TextStyle(
              fontSize: kMediumFontSize,
              fontWeight: kFontbold,
              color: appTheme.textColorHight,
            ),
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              kCategorySubtitle,
              style: TextStyle(
                fontSize: kSmallFontSize,
                fontWeight: kFontLight,
                color: appTheme.textColorLight,
              ),
            ),
          )
        ],
      ),
    );
  }

  FutureBuilder<dynamic> buildCategoryCardList() {
    return FutureBuilder(
      future: fetchCategoryData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var categories = snapshot.data! as List<RecipeCategory>;
          return Container(
            height: kCategoryContainerSize,
            margin: const EdgeInsets.only(top: kLargeSize),
            child: ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.right,
                color: appTheme.blurColor,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: kLargeSize),
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  separatorBuilder: (_, i) {
                    return const SizedBox(width: kLargeSize);
                  },
                  itemBuilder: (_, i) {
                    var category = categories[i];
                    onTap() {
                      textFieldFocusNode.unfocus();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeResultListPage(
                            category: category,
                            title: category.strCategory,
                          ),
                        ),
                      );
                    }

                    return RecipeCategoryCard(
                      category: category,
                      onTap: onTap,
                    );
                  },
                ),
              ),
            ),
          );
        } else {
          return Container(height: kCategoryContainerSize);
        }
      },
    );
  }

  Container buildSurpriseTitle() {
    return Container(
      margin: const EdgeInsets.only(
        top: kLargeSize,
        left: kLargeSize,
        right: kLargeSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kSurpriseTitle,
            style: TextStyle(
              fontSize: kMediumFontSize,
              fontWeight: kFontbold,
              color: appTheme.textColorHight,
            ),
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              kSurpriseSubtitle,
              style: TextStyle(
                fontSize: kSmallFontSize,
                fontWeight: kFontLight,
                color: appTheme.textColorLight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<RecipeMeal> buildSurpriseCard() {
    return FutureBuilder(
      future: getRandomMeal(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var meal = snapshot.data as RecipeMeal;
          return Expanded(
            child: LayoutBuilder(builder: (context, box) {
              onTap() {
                textFieldFocusNode.unfocus();
                Navigator.push(
                  context,
                  // MaterialPageRoute(builder: (context) => PageViewer()),
                  MaterialPageRoute(
                    builder: (context) => RecipeMealPage(
                      meal: RecipeMealFilter(
                        idMeal: meal.idMeal,
                        strMeal: meal.strMeal,
                        strMealThumb: meal.strMealThumb,
                      ),
                    ),
                  ),
                );
              }

              return RecipeCard(meal: meal, onTap: onTap);
            }),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard(
      {Key? key, required this.meal, required this.onTap, this.mealFilter})
      : super(key: key);

  final RecipeMeal meal;
  final RecipeMealFilter? mealFilter;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(
          top: kLargeSize,
          left: kLargeSize,
          right: kLargeSize,
        ),
        child: ClipRRect(
          borderRadius: appTheme.borderRadius,
          child: Stack(
            children: [
              Container(
                color: appTheme.blurColor,
                child: Hero(
                  tag: "RecipeHero",
                  child: CachedNetworkImage(
                    imageUrl: meal.strMealThumb,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    progressIndicatorBuilder: (_, __, downloadProgress) =>
                        Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: CircularProgressIndicator(
                          color: appTheme.textColorHight,
                          value: downloadProgress.progress,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: IntrinsicHeight(
                  child: Container(
                    width: double.infinity,
                    // color: appTheme.blurColor,
                    decoration: BoxDecoration(gradient: appTheme.blurGradient),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: appTheme.imageFilter,
                        child: Padding(
                          padding: const EdgeInsets.all(kLargeSize),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  meal.strMeal,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: kLargeFontSize,
                                    fontWeight: kFontbold,
                                    color: appTheme.textColorHight,
                                  ),
                                ),
                              ),
                              appTheme.verticalGap(4),
                              if (meal.strCategory != null &&
                                  meal.strCategory != " ")
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    "${meal.strArea} ${meal.strCategory}",
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: kMediumFontSize,
                                      fontWeight: kFontMedium,
                                      color: appTheme.textColorMedium,
                                    ),
                                  ),
                                ),
                              appTheme.verticalGap(4),
                              if (meal.strTags != null && meal.strTags != " ")
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    meal.strTags!.replaceAll(",", ", "),
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: kSmallFontSize,
                                      fontWeight: kFontLight,
                                      color: appTheme.textColorLight,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeFilterCard extends StatelessWidget {
  const RecipeFilterCard({
    Key? key,
    required this.meal,
    required this.onTap,
  }) : super(key: key);

  final RecipeMealFilter meal;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(
          top: kLargeSize,
          left: kLargeSize,
          right: kLargeSize,
        ),
        child: ClipRRect(
          borderRadius: appTheme.borderRadius,
          child: Stack(
            children: [
              Container(
                color: appTheme.blurColor,
                child: Hero(
                  tag: "RecipeHero" + meal.idMeal,
                  child: CachedNetworkImage(
                    imageUrl: meal.strMealThumb,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    progressIndicatorBuilder: (_, __, downloadProgress) =>
                        Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: CircularProgressIndicator(
                          color: appTheme.textColorHight,
                          value: downloadProgress.progress,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: IntrinsicHeight(
                  child: Container(
                    width: double.infinity,
                    // color: appTheme.blurColor,
                    decoration: BoxDecoration(gradient: appTheme.blurGradient),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: appTheme.imageFilter,
                        child: Padding(
                          padding: const EdgeInsets.all(kLargeSize),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  meal.strMeal,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: kLargeFontSize,
                                    fontWeight: kFontbold,
                                    color: appTheme.textColorHight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeCategoryCard extends StatelessWidget {
  const RecipeCategoryCard({
    Key? key,
    required this.category,
    required this.onTap,
    this.itemCount,
  }) : super(key: key);

  final RecipeCategory category;
  final void Function() onTap;

  final String? itemCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: appTheme.borderRadius,
        child: Container(
          width: kCategoryContainerSize,
          color: appTheme.blurColor,
          child: Stack(
            children: [
              Container(
                color: appTheme.blurSolidColor,
                width: double.infinity,
                height: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: category.strCategoryThumb,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (_, __, downloadProgress) => Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(
                        color: appTheme.textColorHight,
                        value: downloadProgress.progress,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    // color: appTheme.blurColor,
                    decoration: BoxDecoration(gradient: appTheme.blurGradient),
                    width: double.infinity,
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: appTheme.imageFilter,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Container(
                            height: kCategoryContainerSize / 3,
                            width: kCategoryContainerSize,
                            padding: const EdgeInsets.symmetric(
                              horizontal: kMediumSize,
                              vertical: kSmallSize,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                itemCount != null
                                    ? itemCount!
                                    : category.strCategory,
                                style: TextStyle(
                                  fontSize: kSmallFontSize,
                                  fontWeight: kFontbold,
                                  color: appTheme.textColorHight,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

//
class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
    required this.textFieldFocusNode,
    this.color = Colors.white,
  }) : super(key: key);
  final FocusNode textFieldFocusNode;
  final Color color;
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: appTheme.blurSolidColor,
        borderRadius: appTheme.borderRadius,
      ),
      child: ClipRRect(
        borderRadius: appTheme.borderRadius,
        child: BackdropFilter(
          filter: appTheme.imageFilter,
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              color: appTheme.blurSolidColor,
              borderRadius: appTheme.borderRadius,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(left: 4),
                    child: Center(
                      child: TextField(
                        controller: _textEditingController,
                        focusNode: widget.textFieldFocusNode,
                        enableInteractiveSelection: false,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.bottom,
                        style: TextStyle(
                          color: appTheme.textColorHight,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                        showCursor: false,
                        cursorColor: appTheme.textColorHight,
                        onChanged: (text) {
                          print(_textEditingController.value);
                        },
                        keyboardType: TextInputType.text,
                        onSubmitted: (text) {
                          searchSubmit(context);
                        },
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              searchSubmit(context);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Icon(
                                FlutterIcons.search_mdi,
                                color: appTheme.textColorMedium,
                                size: 32,
                              ),
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          filled: false,
                          hintStyle: TextStyle(color: appTheme.textColorLight),
                          hoverColor: Colors.transparent,
                          hintText: "Search any food",
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
                // const VerticalDivider(
                //   color: Colors.black12,
                //   thickness: 0.5,
                //   indent: 12,
                //   endIndent: 12,
                // ),
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(FlutterIcons.sort_mco, color: Colors.black),
                // )
              ],
            ),
          ),
        ),
      ),
    );
    // return Container /* Search box*/ (
    //   color: Colors.amber,
    //   padding: EdgeInsets.all(8.0),
    //   child: Autocomplete<Continent>(
    //     optionsBuilder: (textEditingValue) {
    //       return continentOptions
    //           .where((Continent continent) => continent.name
    //               .toLowerCase()
    //               .startsWith(textEditingValue.text.toLowerCase()))
    //           .toList();
    //     },
    //   ),
    // );
  }

  void searchSubmit(BuildContext context) {
    print(_textEditingController.value);
    widget.textFieldFocusNode.unfocus();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeResultListPage(
          search: _textEditingController.value.text,
          title: _textEditingController.value.text,
        ),
      ),
    );
  }
}
