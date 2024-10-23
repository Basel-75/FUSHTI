import 'dart:developer';

import 'package:customer_app/screen/bill/bill_screen.dart';
import 'package:customer_app/screen/bottomnavigator/bottom_navigator_screen.dart';
import 'package:customer_app/screen/history/history_screen.dart';
import 'package:customer_app/screen/plan/add_plan_screen.dart';
import 'package:customer_app/screen/plan/plan_cart_screen.dart';
import 'package:customer_app/screen/plan/plan_screen.dart';
import 'package:customer_app/screen/product/product_screen.dart';
import 'package:customer_app/screen/profile/profile_screen.dart';
import 'package:customer_app/screen/auth/login_screen.dart';
import 'package:customer_app/screen/followers/edit_followers_screen.dart';
import 'package:customer_app/screen/followers/followers_profile_screen.dart';
import 'package:customer_app/screen/followers/followers_screen.dart';

import 'package:customer_app/screen/home/home_screen.dart';

import 'package:customer_app/screen/auth/otp_screen.dart';
import 'package:customer_app/screen/auth/signup_screen.dart';
import 'package:customer_app/screen/restrictions/restrictions_screen.dart';
import 'package:database_meth/database_meth.dart';

import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

void main() async {
  //!change the default user model in melos
  WidgetsFlutterBinding.ensureInitialized();

  await setup();
  log('======================\nCurrent user : \n');
  log('${getIt.get<AppModel>().userModel?.toJson()}');
  log('===========================');
  log('======================\nChildren : \n');
  for (var element in getIt.get<AppModel>().userModel!.childModelList) {
    log('${element.toJson()}');
  }
  log('===========================');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
                      backgroundColor: const Color(0xffBA9773)))),

          // debugShowCheckedModeBanner: false,
          home: const BottomNavigatorScreen(),
        ),
      ),
    );
  }
}
