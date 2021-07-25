import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:recipe_for_students_flutter/app/api/base_api.dart';
import 'package:recipe_for_students_flutter/app/api/recipe_filter_api.dart';
import 'package:recipe_for_students_flutter/app/api/recipe_meal_api.dart';
import 'package:recipe_for_students_flutter/app/models/food.dart';
import 'package:recipe_for_students_flutter/app/notifiers/constant.dart';
import 'package:recipe_for_students_flutter/app/notifiers/theme.dart';

class RecipeMealPage extends StatefulWidget {
  const RecipeMealPage({
    Key? key,
    required this.meal,
  }) : super(key: key);

  final RecipeMealFilter meal;
  @override
  _RecipeMealPageState createState() => _RecipeMealPageState();
}

class _RecipeMealPageState extends State<RecipeMealPage> {
  late RecipeMealFilter meal = widget.meal;

  RecipeMeal? fullMeal;

  Future<void> getRecipeById() async {
    var data = await apiProvider.getRecipeById(meal.idMeal);
    setState(() {
      print("Set Data");
      fullMeal = data.meals[0];
    });
  }

  final ScrollController _scrollController = ScrollController();
  double heroOpacity = 1;
  @override
  void initState() {
    getRecipeById();
    _scrollController.addListener(() {
      print(_scrollController.position.maxScrollExtent);
      var flexibleSpaceSize = MediaQuery.of(context).size.height / 3;
      var toolbarHeight = 64;

      var smallest = min(
        _scrollController.position.maxScrollExtent,
        MediaQuery.of(context).size.height / 2,
      );

      var start = flexibleSpaceSize - toolbarHeight;
      var offset = _scrollController.offset;
      if (offset > start || (0 < offset && offset < start)) {
        setState(() {
          heroOpacity = (smallest - offset) / (smallest - start) > 1
              ? 1
              : (smallest - offset) / (smallest - start) < 0
                  ? 0
                  : (smallest - offset) / (smallest - start);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, box) {
          return Container(
            color: appTheme.recipePageBackground,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  // snap: true,
                  // floating: true,
                  automaticallyImplyLeading: false,
                  expandedHeight: MediaQuery.of(context).size.height / 2,
                  pinned: true,
                  toolbarHeight: 64,
                  leadingWidth: 64,
                  title: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: 1 - heroOpacity,
                    child: Text(
                      heroOpacity == 0 ? meal.strMeal : "",
                      style: TextStyle(
                        fontSize: kLargeFontSize,
                        fontWeight: kFontMedium,
                        color: appTheme.textColorHight,
                      ),
                    ),
                  ),
                  leading: Container(
                    padding: const EdgeInsets.all(kMediumSize),
                    child: ClipRRect(
                      borderRadius: appTheme.borderRadius,
                      child: BackdropFilter(
                        filter: appTheme.imageFilter,
                        child: Container(
                          color: appTheme.blurColor,
                          width: 48,
                          height: 48,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: appTheme.textColorHight,
                              size: 20,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  shadowColor: Colors.black,
                  flexibleSpace: Container(
                    color: appTheme.recipePageToolbarBackground,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      opacity: heroOpacity,
                      child: Hero(
                        tag: "RecipeHero",
                        child: CachedNetworkImage(
                          imageUrl: meal.strMealThumb,
                          fit: BoxFit.cover,
                          width: box.maxWidth,
                          height: box.maxHeight,
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
                  ),
                ),
                SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      color: Colors.transparent,
                      margin: const EdgeInsets.only(
                        top: kLargeSize,
                        left: kLargeSize,
                        right: kLargeSize,
                        bottom: kMediumSize,
                      ),
                      width: box.maxWidth / 1.2,
                      child: Text(
                        meal.strMeal,
                        style: TextStyle(
                          fontSize: kLargeFontSize,
                          fontWeight: kFontbold,
                          color: appTheme.textColorHight,
                        ),
                      ),
                    ),
                  ),
                ),
                if (fullMeal == null)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: CircularProgressIndicator(
                          color: appTheme.textColorHight,
                        ),
                      ),
                    ),
                  ),
                if (fullMeal != null)
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(
                          left: kLargeSize,
                          bottom: kMediumSize,
                        ),
                        alignment: Alignment.centerLeft,
                        width: box.maxWidth / 1.4,
                        child: FittedBox(
                          fit: BoxFit.none,
                          child: Text(
                            "${fullMeal!.strArea} ${fullMeal!.strCategory}",
                            style: TextStyle(
                              fontSize: kLargeFontSize,
                              fontWeight: kFontMedium,
                              color: appTheme.textColorHight,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (fullMeal != null && fullMeal!.strTags != null)
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(left: 16, bottom: 8),
                        alignment: Alignment.centerLeft,
                        width: box.maxWidth,
                        child: Text(
                          fullMeal!.strTags!.replaceAll(",", ", "),
                          style: TextStyle(
                            fontSize: kMediumFontSize,
                            fontWeight: kFontLight,
                            color: appTheme.textColorLight,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (fullMeal != null)
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: kLargeSize, left: kLargeSize),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ingredients: ",
                            style: TextStyle(
                              fontSize: kLargeFontSize,
                              fontWeight: kFontbold,
                              color: appTheme.textColorMedium,
                            ),
                          ),
                          const SizedBox(height: kLargeSize),
                          ListView.separated(
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: fullMeal!.ingredients.length,
                            itemBuilder: (_, i) {
                              var ingredient = fullMeal!.ingredients[i];
                              return Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 56,
                                      width: 56,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            appTheme.borderRadiusCircle,
                                        color: appTheme.blurSolidColor,
                                        border: Border.all(
                                            color: appTheme.blurSolidColor,
                                            width: kSmallSize),
                                      ),
                                      child: OverflowBox(
                                        maxHeight: 64,
                                        maxWidth: 64,
                                        child: CachedNetworkImage(
                                          height: 64,
                                          imageUrl:
                                              ingredient.strIngredientThumb,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder:
                                              (_, __, downloadProgress) =>
                                                  Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                              width: 32,
                                              height: 32,
                                              child: CircularProgressIndicator(
                                                color: appTheme.textColorHight,
                                                value:
                                                    downloadProgress.progress,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: kLargeSize),
                                    Text(
                                      ingredient.strIngredient,
                                      style: TextStyle(
                                        color: appTheme.textColorMedium,
                                      ),
                                    ),
                                    Text(
                                      ': ${ingredient.strMeasure}',
                                      style: TextStyle(
                                        color: appTheme.textColorMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (_, i) =>
                                const SizedBox(height: kLargeSize),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (fullMeal != null)
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(
                          top: 32,
                          bottom: 8,
                          left: 16,
                          right: 16,
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Instructions: ",
                              style: TextStyle(
                                fontSize: kLargeFontSize,
                                fontWeight: kFontbold,
                                color: appTheme.textColorMedium,
                              ),
                            ),
                            const SizedBox(height: kLargeSize),
                            Text(
                              fullMeal!.strInstructions,
                              style: TextStyle(
                                  fontSize: kMediumFontSize,
                                  fontWeight: kFontMedium,
                                  color: appTheme.textColorMedium,
                                  height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 32),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
