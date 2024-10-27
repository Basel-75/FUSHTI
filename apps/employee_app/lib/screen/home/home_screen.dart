import 'dart:developer';

import 'package:employee_app/screen/add_product/add_product_screen.dart';
import 'package:employee_app/screen/feedback/feedback_screen.dart';
import 'package:employee_app/screen/home/cubit/home_cubit.dart';
import 'package:employee_app/widget/appbar_emp_header.dart';
import 'package:employee_app/widget/container/card_home_product.dart';
import 'package:employee_app/widget/textTitle/title_name.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> products = [
      {
        'image': 'assets/image/egg.png',
        'name': 'حلويات المراعي',
        'rating': '4.8/5',
        'price': 18,
        'calories': 30,
      },
      {
        'image': 'assets/image/egg.png',
        'name': 'عصير البرتقال',
        'rating': '4.8/5',
        'price': 18,
        'calories': 30,
      },
      {
        'image': 'assets/image/egg.png',
        'name': 'ساندوتش',
        'rating': '4.8/5',
        'price': 18,
        'calories': 30,
      },
      {
        'image': 'assets/image/egg.png',
        'name': 'حلويات المراعي',
        'rating': '4.8/5',
        'price': 18,
        'calories': 30,
      },
      {
        'image': 'assets/image/egg.png',
        'name': 'حلويات المراعي',
        'rating': '4.8/5',
        'price': 18,
        'calories': 30,
      },
      {
        'image': 'assets/image/egg.png',
        'name': 'عصير البرتقال',
        'rating': '4.8/5',
        'price': 18,
        'calories': 30,
      },
      {
        'image': 'assets/image/egg.png',
        'name': 'ساندوتش',
        'rating': '4.8/5',
        'price': 18,
        'calories': 30,
      },
      {
        'image': 'assets/image/egg.png',
        'name': 'حلويات المراعي',
        'rating': '4.8/5',
        'price': 18,
        'calories': 30,
      },
    ];

    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<HomeCubit>();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xffFDCB6A),
              tooltip: 'add Saving',
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (builder) {
                  return const AddProductScreen();
                }));
              },
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(19.h),
              child: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (builder) {
                        return const FeedBackScreen();
                      }));
                    },
                    icon: const Icon(Iconsax.message_2_bold)),
                flexibleSpace: EmployeeHeader(
                  isTitle: false,
                  title: 'اضافة منتج',
                  textSize: 20.sp,
                ),
              ),
            ),
            body: Column(
              children: [
                EmpTitleName(
                  paddingTop: 0.6.h,
                  paddingRight: 2.h,
                  textSize: 18.sp,
                  schoolName: 'كافتيريا الثانوية السابعة للبنات',
                ),
                const Divider(),
                Image.asset('assets/image/emp_home_img.png'),
                EmpTitleName(
                  paddingTop: 0.h,
                  paddingRight: 4.h,
                  textSize: 20.sp,
                  schoolName: 'منتجاتي',
                ),
                SizedBox(
                  height: 1.h,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: cubit.menu.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1.0.h,
                      mainAxisSpacing: 1.0.h,
                      childAspectRatio: 0.12.h,
                    ),
                    padding: EdgeInsets.all(3.h),
                    itemBuilder: (context, index) => ProductCards(
                        image: 'assets/image/egg.png',
                        name: cubit.menu[index].foodName,
                        rating: '4.8',
                        calories: cubit.menu[index].cal,
                        price: cubit.menu[index].price.toInt(),
                        sizeBorder: 1,
                        borderColor: Colors.grey),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
