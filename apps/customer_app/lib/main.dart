
import 'package:customer_app/screen/bottomnavigator/bottom_navigator_screen.dart';




import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

void main() async {
  //!change the default user model in melos
  WidgetsFlutterBinding.ensureInitialized();

  await setup();
  // log('======================\nCurrent user : \n');
  // log('${getIt.get<AppModel>().userModel?.toJson()}');
  // log('===========================');
  // log('======================\nChildren : \n');
  // for (var element in getIt.get<AppModel>().userModel!.childModelList) {
  //   log('${element.toJson()}');
  // }

  // log('======================\nrestrictionFood : \n');
  // try {
  //   for (var element in getIt.get<AppModel>().userModel!.childModelList) {
  //     for (var food in element.restrictionFood) {
  //       log('${food.toJson()}');
  //     }
  //   }
  // } catch (e) {
  //   log('No restrictionFood');
  // }
  //debugPaintSizeEnabled = true;
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
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Readex Pro',
              scaffoldBackgroundColor: Colors.white,
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFEC87F)))),
          home: const BottomNavigatorScreen(),
        ),
      ),
    );
  }
}
