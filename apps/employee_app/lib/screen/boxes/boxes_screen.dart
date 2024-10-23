import 'dart:developer';

import 'package:employee_app/screen/add_product/add_product_screen.dart';
import 'package:employee_app/widget/appbar_emp_header.dart';
import 'package:employee_app/widget/cardProduct/card_prodct_widget.dart';
import 'package:employee_app/widget/textTitle/title_name.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class BoxesScreen extends StatelessWidget {
  const BoxesScreen({super.key});

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
        'name': 'عصير البرتقال',
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
        'name': 'عصير البرتقال',
        'rating': '4.8/5',
        'price': 18,
        'calories': 30,
      },
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffFDCB6A),
          tooltip: 'Increment',
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
              return const AddProductScreen();
            }));
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(19.h),
          child: AppBar(
            leading: IconButton(
                onPressed: () {}, icon: const Icon(Icons.chat_outlined)),
            flexibleSpace: EmployeeHeader(
              isTitle: false,
              title: 'اضافة منتج',
              textSize: 20.sp,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              EmpTitleName(
                paddingTop: 0.6.h,
                paddingRight: 2.h,
                textSize: 18.sp,
                schoolName: 'كافتيريا الثانوية السابعة للبنات',
              ),
              const Divider(),
              EmpTitleName(
                paddingTop: 0.h,
                paddingRight: 4.h,
                textSize: 18.sp,
                schoolName: 'منتجاتي',
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 1.0.h,
                mainAxisSpacing: 1.0.h,
                childAspectRatio: 0.12.h,
                padding: EdgeInsets.all(3.h),
                children: List.generate(products.length, (index) {
                  var product = products[index];
                  return ProductWidgets(
                    deleteButton: () {
                      log('delete done');
                    },
                    editButton: () {
                      log('edit done');
                    },
                    onTap: () {
                      log('${products[index]}');
                    },
                    image: product['image'],
                    name: product['name'],
                    rating: product['rating'],
                    calories: product['calories'],
                    price: product['price'],
                    sizeBorder: 0.9,
                    borderColor: Colors.black26,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
