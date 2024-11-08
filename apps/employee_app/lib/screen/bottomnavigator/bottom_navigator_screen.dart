import 'package:employee_app/screen/order/child_after_serach_screen.dart';
import 'package:employee_app/screen/order/order_screen.dart';
import 'package:employee_app/screen/product/add_product/add_product_screen.dart';
import 'package:employee_app/screen/bottomnavigator/bloc/bottomnavigator_bloc.dart';
import 'package:employee_app/screen/bottomnavigator/cubit/scan_cubit.dart';
import 'package:employee_app/screen/home/home_screen.dart';

import 'package:employee_app/screen/statistics/statistics_screen.dart';
import 'package:employee_app/screen/storage/storage_product_screen.dart';
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
    StorageScreen(),
    StatisticsScreen(),
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

        return BlocListener<ScanCubit, ScanState>(
          listener: (context, state) {
            if (state is ErorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.msg,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.red,
              ));
            }
          },
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: 3.h),
              child: FloatingActionButton(
                shape: const CircleBorder(),
                heroTag: "navFloat",
                backgroundColor: const Color(0xffFDCB6A),
                tooltip: 'add Saving',
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (builder) {
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
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Column(
                                children: [
                                  SizedBox(height: 3.h),
                                  CustomTextFormFelid(
                                    controller: cubit.childNameCon,
                                    label: "اسم الطالب",
                                    hintText: "فهد",
                                    isPassword: false,
                                    width: 70.w,
                                  ),
                                  SizedBox(height: 3.h),
                                  CustomTextFormFelid(
                                    controller: cubit.childClassCon,
                                    label: "فصل الطالب",
                                    hintText: "3 ب",
                                    isPassword: false,
                                    width: 70.w,
                                  ),
                                  SizedBox(height: 3.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomButton(
                                        backgroundColor:
                                            const Color(0xffA3E9BF),
                                        onPressed: () async {
                                          try {
                                            final result =
                                                await BarcodeScanner.scan(
                                              options: ScanOptions(
                                                strings: {
                                                  'cancel':
                                                      _cancelController.text,
                                                  'flash_on':
                                                      _flashOnController.text,
                                                  'flash_off':
                                                      _flashOffController.text,
                                                },
                                                restrictFormat: [
                                                  BarcodeFormat.qr
                                                ],
                                                useCamera: _selectedCamera,
                                                autoEnableFlash:
                                                    _autoEnableFlash,
                                                android: AndroidOptions(
                                                  aspectTolerance:
                                                      _aspectTolerance,
                                                  useAutoFocus: _useAutoFocus,
                                                ),
                                              ),
                                            );

                                            if (result.rawContent.isNotEmpty) {
                                              final childIdFromBarcode =
                                                  result.rawContent;

                                              await cubit.getChild(
                                                  id: childIdFromBarcode);

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderScreen(
                                                      childModel:
                                                          cubit.childModel!,
                                                    ),
                                                  ));
                                            }
                                          } on PlatformException catch (e) {
                                            scanResult = ScanResult(
                                              rawContent: e.code ==
                                                      BarcodeScanner
                                                          .cameraAccessDenied
                                                  ? 'The user did not grant the camera permission!'
                                                  : 'Unknown error: ${e.message}',
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content:
                                                  Text(scanResult!.rawContent),
                                              backgroundColor: Colors.red[300],
                                            ));
                                          }
                                        },
                                        title: "مسح باركود",
                                        fixedSize: Size(35.w, 4.h),
                                      ),
                                      CustomButton(
                                        backgroundColor:
                                            const Color(0xffC8E5F5),
                                        onPressed: () async {
                                          // await cubit.getchild();

                                          if (cubit.checkTheCOn()) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChildAfterSerachScreen(
                                                  childClass: cubit
                                                          .childClassCon
                                                          .text
                                                          .isEmpty
                                                      ? null
                                                      : cubit
                                                          .childClassCon.text,
                                                  childName:
                                                      cubit.childNameCon.text,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        title: "بحث",
                                        fixedSize: Size(35.w, 4.h),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Iconsax.scan_barcode_outline),
                ),
              ),
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
                      bloc.add(
                          NavigatorBetweenScreenEvent(selectedIndex: index));
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
                          BoxIcons.bx_box,
                          color: Color(0xFFFDCB6A),
                          size: 30,
                        ),
                        title: const Text('المخزون'),
                      ),
                      FlashyTabBarItem(
                        icon: const Icon(
                          LineAwesome.chart_bar_solid,
                          color: Color(0xFFFDCB6A),
                          size: 30,
                        ),
                        title: const Text('الاحصائيات'),
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
          ),
        );
      }),
    );
  }
}
