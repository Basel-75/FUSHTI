import 'dart:developer';

import 'package:employee_app/widget/container/card_feedback.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        'name': '1سعد العتيبي',
        'description': 'الأطعمة تحتاج إلى تحسين الجودة وتقديم تنوع أكبر.',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '2ليلى الشهري',
        'description':
            'أقترح توفير خيارات صحية أكثر، مثل السلطات والفواكه الطازجة.',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '3ناصر القحطاني',
        'description': 'الأسعار مرتفعة مقارنة بجودة الأطعمة المقدمة.',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '4أحمد المطيري',
        'description':
            'نحتاج إلى توفير أطعمة للأطفال تتناسب مع احتياجاتهم الغذائية.',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '5نورة العبدلي',
        'description': 'يجب تحسين نظافة الكافيتيريا والحفاظ على نضارة الأطعمة.',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '6ماجد العمري',
        'description':
            'أقترح إضافة قائمة طعام جديدة بشكل دوري لتجربة أطعمة مختلفة.',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '7فاطمة الهاشمي',
        'description':
            'الأطعمة تحتوي على الكثير من الزيوت، أقترح توفير خيارات قليلة الدهون.',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '8خالد العسيري',
        'description': 'يرجى تحسين جودة العصائر الطازجة وتقليل السكر المضاف.',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '9هدى الكعبي',
        'description': 'أقترح توفير وجبات خفيفة بأسعار معقولة لطلاب المدرسة.',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '10ياسر الحربي',
        'description':
            'الوجبات تُقدم باردة في بعض الأحيان، يجب التأكد من تسخينها قبل التقديم.',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '11ريم الزهراني',
        'description': 'نرجو توفير خيارات للنباتيين وتوفير تصنيف واضح للوجبات.',
        'image': 'assets/image/userprofile.png',
      },
      {
        'name': '12عبدالرحمن الغامدي',
        'description':
            'يجب تحسين قائمة الوجبات وتقديم وجبات جديدة بصورة دورية.',
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
