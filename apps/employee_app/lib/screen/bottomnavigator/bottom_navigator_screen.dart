import 'package:database_meth/database/super_main.dart';

import 'package:employee_app/screen/product/add_product/add_product_screen.dart';

import 'package:employee_app/screen/bottomnavigator/bloc/bottomnavigator_bloc.dart';
import 'package:employee_app/screen/bottomnavigator/cubit/scan_cubit.dart';
import 'package:employee_app/screen/boxes/boxes_screen.dart';
import 'package:employee_app/screen/home/home_screen.dart';

import 'package:employee_app/screen/order/order_screen.dart';

import 'package:employee_app/screen/profile/profile_screen.dart';

import 'package:employee_app/screen/statistics/statistics_screen.dart';
import 'package:employee_app/widget/button/custome_button.dart';
import 'package:employee_app/widget/textFormField/custome_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class BottomNavigatorScreen extends StatelessWidget {
  BottomNavigatorScreen({super.key});

  ScanResult? scanResult;

  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');

  final _aspectTolerance = 0.00;
  final _selectedCamera = -1;
  final _useAutoFocus = true;
  final _autoEnableFlash = false;

  final List<Widget> screens = const [
    HomeScreen(),
    BoxesScreen(),
    StatisticsScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomnavigatorBloc(),
        ),
        BlocProvider(
          create: (context) => ScanCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        final bloc = context.read<BottomnavigatorBloc>();
        final cubit = context.read<ScanCubit>();
        int selectedIndex = 0;
        return Scaffold(
          //extendBody: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: FloatingActionButton(
            heroTag: "navFloat",
            backgroundColor: const Color(0xffFDCB6A),
            tooltip: 'add Saving',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
                return const AddProductScreen();
              }));
            },
            child: IconButton(
                onPressed: () async {
                  // here scan
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                          height: 50.h,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 3.h,
                              ),
                              CustomTextFormFelid(
                                label: "اسم الطالب",
                                hintText: "الاسم",
                                isPassword: false,
                                width: 60.w,
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              CustomTextFormFelid(
                                label: "فصل الطالب",
                                hintText: "الفصل",
                                isPassword: false,
                                width: 60.w,
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              CustomButton(
                                onPressed: () async {
                                  // here scan

                                  try {
                                    final result = await BarcodeScanner.scan(
                                      options: ScanOptions(
                                        strings: {
                                          'cancel': _cancelController.text,
                                          'flash_on': _flashOnController.text,
                                          'flash_off': _flashOffController.text,
                                        },
                                        restrictFormat: [BarcodeFormat.qr],
                                        useCamera: _selectedCamera,
                                        autoEnableFlash: _autoEnableFlash,
                                        android: AndroidOptions(
                                          aspectTolerance: _aspectTolerance,
                                          useAutoFocus: _useAutoFocus,
                                        ),
                                      ),
                                    );

                                    if (result.rawContent.isNotEmpty) {
                                      // change it to take the value from databse later
                                      //  result.rawContent = "d89d5dd5-5487-4065-9116-9d1bfe271000";
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) => OrderScreen(
                                      //         childModel: childm ,
                                      //          ),
                                      //     ));
                                    }
                                  } on PlatformException catch (e) {
                                    scanResult = ScanResult(
                                      rawContent: e.code ==
                                              BarcodeScanner.cameraAccessDenied
                                          ? 'The user did not grant the camera permission!'
                                          : 'Unknown error: //',
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(scanResult!.rawContent),
                                      backgroundColor: Colors.red[300],
                                    ));
                                  }
                                },
                                title: "مسح باركود",
                                fixedSize: Size(40.w, 4.h),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              CustomButton(
                                onPressed: () async {
                                  await cubit.getchild();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderScreen(
                                          childModel: cubit.childModel!,
                                        ),
                                      ));
                                },
                                title: "ابحث",
                                fixedSize: Size(40.w, 4.h),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Iconsax.scan_barcode_outline)),
          ),
          bottomNavigationBar: Directionality(
            textDirection: TextDirection.rtl,
            child: BlocBuilder<BottomnavigatorBloc, BottomnavigatorState>(
              builder: (context, state) {
                if (state is IndexChangeState) {
                  selectedIndex = state.index;
                }
                return FlashyTabBar(
                  onItemSelected: (index) {
                    bloc.add(NavigatorBetweenScreenEvent(selectedIndex: index));
                  },
                  selectedIndex: selectedIndex,
                  items: [
                    FlashyTabBarItem(
                      icon: const Icon(
                        Iconsax.home_bold,
                        color: Color(0xFFFDCB6A),
                        size: 30,
                      ),
                      title: const Text('الرئيسية'),
                    ),
                    FlashyTabBarItem(
                      icon: const Icon(
                        // BoxIcons.bxs_food_menu
                        IonIcons.fast_food,
                        color: Color(0xFFFDCB6A),
                        size: 30,
                      ),
                      title: const Text('الوجبات'),
                    ),
                    FlashyTabBarItem(
                      icon: const Icon(
                        LineAwesome.chart_bar_solid,
                        color: Color(0xFFFDCB6A),
                        size: 30,
                      ),
                      title: const Text('الاحصائيات'),
                    ),
                    FlashyTabBarItem(
                      icon: const Icon(
                        Iconsax.profile_2user_bold,
                        color: Color(0xFFFDCB6A),
                        size: 30,
                      ),
                      title: const Text('صفحتي'),
                    ),
                  ],
                );
              },
            ),
          ),
          body: BlocBuilder<BottomnavigatorBloc, BottomnavigatorState>(
            builder: (context, state) {
              return screens[bloc.currentScreenIndex];
            },
          ),
        );
      }),
    );
  }
}
