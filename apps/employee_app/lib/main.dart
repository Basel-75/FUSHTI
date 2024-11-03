import 'dart:developer';

import 'package:employee_app/screen/bottomnavigator/bottom_navigator_screen.dart'
    as bot;
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/emp_setup.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

void main() async {
  await empSetup();
  OneSignal.initialize(dotenv.env["onesignal_app_key"]!);
  OneSignal.Notifications.requestPermission(true);
  log("${getIt.get<AppModel>().empModel!.toJson()}");
  OneSignal.initialize(dotenv.env["onesignal_app_key"]!);
  //log("${getIt.get<AppModel>().empModel!.schoolModel.foodMenuModelList[0].toJson()}");
  //debugPaintSizeEnabled = true;

  // OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  // //!test login
  // OneSignal.login(getIt.get<AppModel>().userModel!.id);
  log('-----####');
  // log("${getIt.get<AppModel>().userModel!.id}");

  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, screenType) => Directionality(
              textDirection: TextDirection.rtl,
              child: MaterialApp(
                theme: ThemeData(
                    fontFamily: 'Readex Pro',
                    scaffoldBackgroundColor: Colors.white,
                    elevatedButtonTheme: ElevatedButtonThemeData(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFEC87F)))),
                home: bot.BottomNavigatorScreen(),
              ),
            ));
  }
}
