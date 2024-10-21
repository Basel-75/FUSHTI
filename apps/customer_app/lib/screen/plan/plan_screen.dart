import 'package:customer_app/screen/home/home_screen.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/container/plan_item_container.dart';
import 'package:customer_app/widget/container/profile_small_container.dart';
import 'package:customer_app/widget/container/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScreenHeader(
                parentName: '',
                title: 'الخطط',
                inHomeScreen: false,
                funds: '',
                childSchollName: '',
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'التابعين',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Row(
                        children: [
                          CustomRadioButton(
                            height: 10.h,

                            customShape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            enableShape: true,
                            elevation: 0,
                            //absoluteZeroSpacing: true,
                            unSelectedColor: const Color(0xffe5dfcf),
                            buttonLables: const [
                              'احمد',
                              'انس',
                              'احمد',
                              'خالد',
                            ],
                            buttonValues: const [
                              'احمد',
                              'انس',
                              'داحمد',
                              'خالد',
                            ],
                            buttonTextStyle: const ButtonTextStyle(
                                selectedColor: Colors.white,
                                unSelectedColor: Colors.black,
                                textStyle: TextStyle(fontSize: 16)),
                            radioButtonValue: (value) {
                              print(value);
                            },
                            selectedColor: Colors.blueAccent,
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'الخطط',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Row(
                        children: [
                          CustomRadioButton(
                            height: 10.h,

                            customShape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            enableShape: true,
                            elevation: 0,
                            //absoluteZeroSpacing: true,
                            unSelectedColor: const Color(0xffe5dfcf),
                            buttonLables: const [
                              'خطة 1',
                              'خطة 2',
                              'خطة 3',
                              'خطة 4',
                            ],
                            buttonValues: const [
                              'احمد',
                              'انس',
                              'داحمد',
                              'خالد',
                            ],
                            buttonTextStyle: const ButtonTextStyle(
                                selectedColor: Colors.white,
                                unSelectedColor: Colors.black,
                                textStyle: TextStyle(fontSize: 16)),
                            radioButtonValue: (value) {
                              print(value);
                            },
                            selectedColor: Colors.blueAccent,
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'الاطعمة المخصصة',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    SizedBox(
                      height: 45.h,
                      child: GridView.builder(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 1.h),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: 10,
                        itemBuilder: (context, index) => PlanItemContainer(
                          itemName: 'بوكس السعادة',
                          imagePath: 'assets/image/lez.png',
                          onDelete: () {},
                        ),
                      ),
                    ),
                    const Divider(),
                    Center(
                        child: CustomButton(onPressed: () {}, title: 'الدفع'))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
