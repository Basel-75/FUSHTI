import 'package:employee_app/screen/bottomnavigator/bottom_navigator_screen.dart'
    as bot;
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/emp_setup.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

void main() async {
  await empSetup();
  OneSignal.initialize(dotenv.env["onesignal_app_key"]!);
  OneSignal.Notifications.requestPermission(true);

  OneSignal.initialize(dotenv.env["onesignal_app_key"]!);

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
                debugShowCheckedModeBanner: false,
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
