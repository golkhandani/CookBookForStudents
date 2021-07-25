import 'package:flutter/material.dart';
import 'package:recipe_for_students_flutter/app/notifiers/constant.dart';
import 'package:recipe_for_students_flutter/app/notifiers/theme.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool switchVal = appTheme.currentTheme == ThemeType.dark ? false : true;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: appTheme.settingPageBackground,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(
                top: kLargeSize,
                left: kLargeSize,
                right: kLargeSize,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Theme",
                    style: TextStyle(
                      fontSize: kLargeFontSize,
                      fontWeight: kFontbold,
                      color: appTheme.textColorHight,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text(
                          "Dark",
                          style: TextStyle(
                            fontSize: kMediumFontSize,
                            fontWeight: kFontbold,
                            color: appTheme.textColorHight,
                          ),
                        ),
                        Switch(
                            value: switchVal,
                            activeColor: Colors.white,
                            hoverColor: Colors.green,
                            activeTrackColor: Colors.blue,
                            splashRadius: 30,
                            trackColor: MaterialStateProperty.all(
                              switchVal ? Colors.amber : Colors.grey,
                            ),
                            inactiveThumbColor: Colors.grey,
                            inactiveThumbImage:
                                const AssetImage('assets/moon.png'),
                            activeThumbImage:
                                const AssetImage('assets/sun.png'),
                            onChanged: (val) {
                              setState(() {
                                switchVal = !switchVal;
                                appTheme.switchTheme();
                              });
                            }),
                        Text(
                          "Light",
                          style: TextStyle(
                            fontSize: kMediumFontSize,
                            fontWeight: kFontbold,
                            color: appTheme.textColorHight,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
