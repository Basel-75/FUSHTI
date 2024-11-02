import 'dart:developer';

import 'package:employee_app/widget/appbar_emp_header.dart';
import 'package:employee_app/widget/container/card_feedback.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        'name': '1عمار اللقماني',
        'description': 'برنت, برنت, لوقر لوقر, 100% لوجيك',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '2محمد الزهراني',
        'description': 'تطبيقكم ممتاز ولكن يحتاج الى مصممين احسنتم',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '3عبدالله الحربي',
        'description':
            'مبرمج تطبيقاتيسميىريسىرمسنىرنسيىمرنىسنيىرمنسيىرمنسيىرمىسيمرىسسويىؤسيترىنيرتىستينرىيستنرنيىرنتىيسنترىسيتنرىنيسترىنتيىرتنسيرىتنيرنتنميرىمنيسىرنمسيىنمرىمن',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '4عمار اللقماني',
        'description': 'برنت, برنت, لوقر لوقر, 100% لوجيك',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '5محمد الزهراني',
        'description': 'تطبيقكم ممتاز ولكن يحتاج الى مصممين احسنتم',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '6عبدالله الحربي',
        'description':
            'مبرمج تطبيقاتيسميىريسىرمسنىرنسيىمرنىسنيىرمنسيىرمنسيىرمىسيمرىسسويىؤسيترىنيرتىستينرىيستنرنيىرنتىيسنترىسيتنرىنيسترىنتيىرتنسيرىتنيرنتنميرىمنيسىرنمسيىنمرىمن',
        'image': 'assets/image/userprofile.png',
      },
      //
      {
        'name': '7عمار اللقماني',
        'description': 'برنت, برنت, لوقر لوقر, 100% لوجيك',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '8محمد الزهراني',
        'description': 'تطبيقكم ممتاز ولكن يحتاج الى مصممين احسنتم',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '9عبدالله الحربي',
        'description':
            'مبرمج تطبيقاتيسميىريسىرمسنىرنسيىمرنىسنيىرمنسيىرمنسيىرمىسيمرىسسويىؤسيترىنيرتىستينرىيستنرنيىرنتىيسنترىسيتنرىنيسترىنتيىرتنسيرىتنيرنتنميرىمنيسىرنمسيىنمرىمن',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '10عمار اللقماني',
        'description': 'برنت, برنت, لوقر لوقر, 100% لوجيك',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '11محمد الزهراني',
        'description': 'تطبيقكم ممتاز ولكن يحتاج الى مصممين احسنتم',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '12عبدالله الحربي',
        'description':
            'مبرمج تطبيقاتيسميىريسىرمسنىرنسيىمرنىسنيىرمنسيىرمنسيىرمىسيمرىسسويىؤسيترىنيرتىستينرىيستنرنيىرنتىيسنترىسيتنرىنيسترىنتيىرتنسيرىتنيرنتنميرىمنيسىرنمسيىنمرىمن',
        'image': 'assets/image/userprofile.png',
      },
    ];
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              title: Text(
                'الشكاوى و الاقتراحات',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              centerTitle: true,
              flexibleSpace: Container(
                //height: 15.h,
                decoration: const BoxDecoration(
                  color: Color(0xff6FBAE5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
              ),
              toolbarHeight: 11.h,
            ),
            body: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var feedBack = data[index];

                  return CartFeedBack(
                    description: feedBack['description'],
                    image: feedBack['image'],
                    name: feedBack['name'],
                    onTap: () {
                      log('feedBack ${feedBack['name']} Deleted');
                    },
                  );
                })));
  }
}
