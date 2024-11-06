import 'package:customer_app/screen/auth/login_screen.dart';
import 'package:customer_app/screen/bottomnavigator/bottom_navigator_screen.dart';
import 'package:customer_app/screen/profile/bloc/profile_bloc.dart';
import 'package:database_meth/database/super_main.dart';

import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

void main() async {
  //!change the default user model in melos
  WidgetsFlutterBinding.ensureInitialized();

  await setup();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    return Sizer(
      builder: (context, orientation, screenType) => Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: (context) => ProfileBloc()..add(GetUserInfoEvent()),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: 'Readex Pro',
                scaffoldBackgroundColor: Colors.white,
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFEC87F)))),
            home: session == null
                ? const LoginScreen()
                : const BottomNavigatorScreen(),
          ),
        ),
      ),
    );
  }
}
