import 'package:employee_app/screen/statistics/statistics_screen.dart';
import 'package:employee_app/screen/storage/storage_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

void main() {
  //debugPaintSizeEnabled = true;
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
                            backgroundColor: const Color(0xffBA9773)))),
                home: const StatisticsScreen(),
              ),
            ));
  }
}
