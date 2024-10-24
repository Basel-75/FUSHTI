import 'dart:developer';

import 'package:employee_app/widget/appbar_emp_header.dart';
import 'package:employee_app/widget/container/card_storage.dart';
import 'package:employee_app/widget/textTitle/title_name.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class StorageScreen extends StatelessWidget {
  const StorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        'name': 'ساندوتش بيض',
        'description': '13',
        'image': 'assets/image/egg.png',
        'status': true,
      },
      {
        'name': 'ليز',
        'description': '7',
        'image': 'assets/image/lez.png',
        'status': true,
      },
      {
        'name': 'وجبة السعادة',
        'description': '9',
        'image': 'assets/image/boxImage.png',
        'status': false,
      },
      {
        'name': 'ساندوتش بيض',
        'description': '31',
        'image': 'assets/image/egg.png',
        'status': true,
      },
      {
        'name': 'ليز',
        'description': '2',
        'image': 'assets/image/lez.png',
        'status': false,
      },
      {
        'name': 'وجبة السعادة',
        'description': '10',
        'image': 'assets/image/boxImage.png',
        'status': false,
      },
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(19.h),
          child: AppBar(
            flexibleSpace: EmployeeHeader(
              isTitle: true,
              title: 'إدارة المخزون',
              textSize: 20.sp,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            Image.asset('assets/image/storage_img.png'),
            EmpTitleName(
              paddingTop: 0.6.h,
              paddingRight: 2.h,
              textSize: 18.sp,
              schoolName: 'منتجاتي',
            ),
            SizedBox(
              height: 3.h,
            ),
            SizedBox(
              height: 40.h,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var feedBack = data[index];

                  return CardStorage(
                    activeText: 'OOS',
                    inactiveText: 'avail',
                    sizeSwitch: 20.w,
                    
                    onChanged: (value) {
                      if (value == true) {
                        log('Item is available');
                      } else {
                        log('Item is out of stock');

                      }
                    },
                    quantity: feedBack['description'],
                    image: feedBack['image'],
                    name: feedBack['name'],
                    onTap: () {
                      log('feedBack ${feedBack['name']} Deleted');
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
