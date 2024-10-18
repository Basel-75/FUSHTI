import 'package:customer_app/screen/auth/login_screen.dart';
import 'package:customer_app/screen/auth/otp_screen.dart';
import 'package:customer_app/screen/auth/signup_screen.dart';
import 'package:database_meth/database_meth.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

void main() async {
  
   WidgetsFlutterBinding.ensureInitialized();

   await initPkg();
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
              scaffoldBackgroundColor: Colors.white,
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff34673F)))),
          debugShowCheckedModeBanner: false,
          home: const LoginScreen(),
        ),
      ),
    );
  }
}
