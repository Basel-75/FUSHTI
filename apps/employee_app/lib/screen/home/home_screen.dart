import 'dart:developer';

import 'package:employee_app/widget/appbar_emp_header.dart';
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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffFDCB6A),
          tooltip: 'Increment',
          onPressed: () {},
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(19.h),
          child: AppBar(
            leading: IconButton(
                onPressed: () {}, icon: const Icon(Icons.chat_outlined)),
            flexibleSpace: const EmployeeHeader(
              isTitle: false,
              title: 'اضافة منتج',
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
              child: GridView.count(
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
            )
          ],
        ),
      ),
    );
  }
}

class ProductWidgets extends StatelessWidget {
  const ProductWidgets({
    super.key,
    // required this.products,
    // required this.product,
    this.onTap,
    this.editButton,
    this.deleteButton,
    required this.image,
    required this.name,
    required this.rating,
    required this.calories,
    required this.price,
    required this.sizeBorder,
    required this.borderColor,
  });

  // final List<Map<String, dynamic>> products;
  // final Map<String, dynamic> product;
  final void Function()? onTap;
  final void Function()? editButton;
  final void Function()? deleteButton;
  final String image;
  final String name;
  final String rating;
  final int calories;
  final int price;
  final double sizeBorder;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(0.8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: sizeBorder, color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: deleteButton,
                  child: Icon(Icons.disabled_by_default_outlined,
                      size: 20.sp, color: Colors.red),
                ),
                InkWell(
                  onTap: editButton,
                  child: Icon(Icons.edit, size: 20.sp, color: Colors.grey),
                ),
              ],
            ),
            Image.asset(
              image,
              height: 8.5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    Text(
                      rating,
                      style: TextStyle(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${calories} سعرة',
                  style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                ),
                Text(
                  '${price} رس',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmpCategoryTitle extends StatelessWidget {
  const EmpCategoryTitle({
    super.key,
    required this.nameCategory,
    required this.textSize,
  });
  final String nameCategory;
  final double textSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4.h),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          nameCategory,
          style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class EmpTitleName extends StatelessWidget {
  const EmpTitleName({
    super.key,
    required this.schoolName,
    required this.textSize,
    required this.paddingRight,
    required this.paddingTop,
  });
  final String schoolName;
  final double textSize;
  final double paddingRight;
  final double paddingTop;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: paddingRight, top: paddingTop),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          schoolName,
          style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
