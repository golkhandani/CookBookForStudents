import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recipe_for_students_flutter/app/api/base_api.dart';
import 'package:recipe_for_students_flutter/app/models/application_page.dart';
import 'package:recipe_for_students_flutter/app/notifiers/constant.dart';
import 'package:recipe_for_students_flutter/app/notifiers/theme.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        fontFamily: GoogleFonts.montserrat(
                // fontStyle: FontStyle.normal,
                // height: 1.6,
                // letterSpacing: 2,
                // wordSpacing: 1,
                )
            .fontFamily,
      ),
      home: const SplashLoadingPage(),
    );
  }
}

class SplashLoadingPage extends StatefulWidget {
  const SplashLoadingPage({Key? key}) : super(key: key);

  @override
  _SplashLoadingPageState createState() => _SplashLoadingPageState();
}

class _SplashLoadingPageState extends State<SplashLoadingPage> {
  initApp() async {
    await appTheme.loadTheme();
    await apiProvider.getCategory();
    await apiProvider.getRandomMeal();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PageViewer(),
      ),
    );
  }

  @override
  void initState() {
    initApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash-loading.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Text(
              "Welcome To",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: kLargeFontSize * 1.4,
                fontWeight: kFontbold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: kMediumSize),
            Text(
              "NY Cook Book",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: kLargeFontSize * 2,
                fontWeight: kFontbold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: kLargeSize),
            Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageViewer extends StatefulWidget {
  const PageViewer({Key? key}) : super(key: key);

  @override
  _PageViewerState createState() => _PageViewerState();
}

class _PageViewerState extends State<PageViewer> {
  late ApplicationPage _selectedPage = pages[0];
  final PageController _pageController = PageController(initialPage: 0);
  Color dockColor = appTheme.blurSolidColor;

  changeDockColor() {
    setState(() {
      dockColor = appTheme.blurSolidColor;
    });
  }

  @override
  void initState() {
    appTheme.addListener(changeDockColor);

    super.initState();
  }

  @override
  void dispose() {
    appTheme.removeListener(changeDockColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Builder(builder: (context) {
          return Stack(
            children: [
              PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, i) {
                    return pages[i].widget;
                  }),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(kLargeSize),
                  child: ClipRRect(
                    borderRadius: appTheme.borderRadius,
                    child: BackdropFilter(
                      filter: appTheme.imageFilter,
                      child: Container(
                        height: 54,
                        decoration: BoxDecoration(
                          color: dockColor,
                          borderRadius: appTheme.borderRadius,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: pages.map((page) {
                            var isSelected = page == _selectedPage;
                            return GestureDetector(
                              onTap: () {
                                changePage(page);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                width:
                                    (MediaQuery.of(context).size.width - 64) /
                                        pages.length,
                                color: Colors.transparent,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        page.iconData,
                                        size: isSelected ? 30 : 20,
                                        color: isSelected
                                            ? page.color
                                            : appTheme.dockTextColor,
                                      ),
                                      Text(
                                        page.name,
                                        style: TextStyle(
                                          color: isSelected
                                              ? page.color
                                              : appTheme.dockTextColor,
                                          fontSize: isSelected ? 12 : 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ]),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  void changePage(ApplicationPage page) {
    var pageIndex = pages.indexWhere((element) => page == element);
    setState(() {
      _selectedPage = pages.firstWhere((element) => page == element);
      _pageController.jumpToPage(pageIndex);
    });
  }
}
