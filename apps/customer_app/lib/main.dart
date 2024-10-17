import 'package:customer_app/screen/login_screen.dart';
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Column(
        children: [Icon(FontAwesome.safari_brand)],
      ),
    );
  }
}
