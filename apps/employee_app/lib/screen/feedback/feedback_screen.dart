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
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(19.h),
              child: AppBar(
                flexibleSpace: EmployeeHeader(
                  isTitle: true,
                  title: 'الأقتراحات والشكاوى',
                  textSize: 20.sp,
                ),
              ),
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
