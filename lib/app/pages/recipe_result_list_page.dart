import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_for_students_flutter/app/api/base_api.dart';
import 'package:recipe_for_students_flutter/app/api/recipe_category_api.dart';
import 'package:recipe_for_students_flutter/app/api/recipe_filter_api.dart';
import 'package:recipe_for_students_flutter/app/api/recipe_meal_api.dart';
import 'package:recipe_for_students_flutter/app/notifiers/constant.dart';
import 'package:recipe_for_students_flutter/app/notifiers/theme.dart';
import 'package:recipe_for_students_flutter/app/pages/recipe_list_page.dart';
import 'package:recipe_for_students_flutter/app/pages/recipe_meal_page.dart';

class RecipeResultListPage extends StatefulWidget {
  const RecipeResultListPage({
    Key? key,
    required this.title,
    this.category,
    this.search,
  }) : super(key: key);

  final RecipeCategory? category;
  final String? search;
  final String title;
  @override
  _RecipeResultListPageState createState() => _RecipeResultListPageState();
}

enum PageState { loading, loaded, reload, failed }

class _RecipeResultListPageState extends State<RecipeResultListPage> {
  late RecipeCategory? category = widget.category;
  late String? search = widget.search;
  late String title = widget.title;

  late PageState pageState = PageState.loading;

  late List<RecipeMealFilter> meals;
  late int totalItem = 0;
  Future<void> getMeals() async {
    if (category != null) {
      var data = await apiProvider.getRecipeByCategoryFilter(
        category!.strCategory,
      );
      meals = data.meals;
      meals.shuffle();
      totalItem = meals.length;
      setState(() {
        pageState = PageState.loaded;
      });
    } else if (search != null) {
      var data = await apiProvider.getRecipeBySearch(
        search!,
      );
      meals = data.meals;
      meals.shuffle();
      totalItem = meals.length;
      setState(() {
        pageState = PageState.loaded;
      });
    } else {
      meals = [];
      setState(() {
        pageState = PageState.failed;
      });
    }
  }

  @override
  void initState() {
    getMeals();
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
              slivers: [
                SliverAppBar(
                    backgroundColor: appTheme.recipePageToolbarBackground,
                    pinned: true,
                    automaticallyImplyLeading: false,
                    toolbarHeight: 64,
                    leadingWidth: 64,
                    leading: Container(
                      padding: EdgeInsets.all(8),
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
                    title: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: kLargeFontSize,
                          fontWeight: kFontMedium,
                          color: appTheme.textColorHight,
                        ),
                      ),
                    )),
                if (category != null)
                  SliverToBoxAdapter(
                    child: Align(
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: kLargeSize,
                          left: kLargeSize,
                          right: kLargeSize,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: kCategoryContainerSize,
                                  width: kCategoryContainerSize,
                                  child: RecipeCategoryCard(
                                    category: category!,
                                    onTap: () {},
                                    itemCount: '${totalItem.toString()} Items',
                                  ),
                                ),
                                const SizedBox(height: kMediumSize),
                              ],
                            ),
                            const SizedBox(width: kLargeSize),
                            Expanded(
                              child: Text(
                                category!.strCategoryDescription,
                                style: TextStyle(
                                  fontSize: kSmallFontSize,
                                  fontWeight: kFontMedium,
                                  color: appTheme.textColorMedium,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                /** List View */

                Builder(
                  builder: (_) {
                    if (pageState == PageState.loaded) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, i) {
                            var meal = meals[i];
                            return Container(
                              color: Colors.transparent,
                              height: box.maxHeight / 2,
                              // margin: const EdgeInsets.all(16),
                              child: LayoutBuilder(builder: (context, box) {
                                onTap() {
                                  Navigator.push(
                                    context,
                                    // MaterialPageRoute(builder: (context) => PageViewer()),
                                    MaterialPageRoute(
                                      builder: (context) => RecipeMealPage(
                                        meal: meal,
                                      ),
                                    ),
                                  );
                                }

                                return RecipeFilterCard(
                                  meal: meal,
                                  onTap: onTap,
                                );
                              }),
                            );
                          },
                          childCount: meals.length,
                        ),
                      );
                    } else {
                      return SliverFillRemaining(
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
                      );
                    }
                  },
                ),

                // SliverToBoxAdapter(
                //   child: FutureBuilder(
                //     builder: (_, snapshot) {
                //       return ListView.separated(
                //         scrollDirection: Axis.vertical,
                //         itemBuilder: (_, i) {
                //           return Align(
                //             child: Container(
                //               color: Colors.red,
                //               width: 300,
                //               height: 400,
                //             ),
                //           );
                //         },
                //         separatorBuilder: (_, i) => const SizedBox(height: 16),
                //         itemCount: 10,
                //       );
                //     },
                //   ),
                // )
              ],
            ),
          );
        }),
      ),
    );
  }
}
