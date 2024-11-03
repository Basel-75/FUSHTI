import 'package:employee_app/screen/product/add_product/add_product_screen.dart';
import 'package:employee_app/screen/feedback/feedback_screen.dart';
import 'package:employee_app/screen/storage/storage_product_screen.dart';
import 'package:employee_app/widget/appbar_emp_header.dart';
import 'package:employee_app/widget/container/container_statistics.dart';
import 'package:employee_app/widget/textTitle/title_name.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (builder) {
                  return const FeedBackScreen();
                }));
              },
              icon: const Icon(
                Bootstrap.chat_text_fill,
                color: Colors.white,
              )),
          title: Image.asset('assets/image/mainLogo.png'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const ShapeDecoration(
              shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius.only(
                bottomLeft:
                    SmoothRadius(cornerRadius: 50, cornerSmoothing: 0.1),
                bottomRight:
                    SmoothRadius(cornerRadius: 50, cornerSmoothing: 0.1),
              )),
              color: Color(0xff6FBAE5),
            ),
          ),
          toolbarHeight: 15.h,
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
            SizedBox(
              height: 2.h,
            ),
            EmpTitleName(
              paddingRight: 2.h,
              schoolName: 'أرقام',
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ContainerStatistics(
                    statisticsName: 'المبيعات',
                    statisticsNumber: 876,
                    statisticsIcon: Icon(
                      Icons.add_chart_outlined,
                      color: const Color(0xff06374E).withOpacity(0.80),
                    ),
                    containerColor: const Color(0xffF6FAFD)),
                ContainerStatistics(
                    statisticsName: 'الدخل',
                    statisticsNumber: 876,
                    statisticsIcon: Icon(
                      Icons.pie_chart,
                      color: const Color(0xff06374E).withOpacity(0.80),
                    ),
                    containerColor: const Color(0xffF6FAFD)),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ContainerStatistics(
                    statisticsName: 'الطلبات',
                    statisticsNumber: 876,
                    statisticsIcon: Icon(
                      Icons.area_chart_outlined,
                      color: const Color(0xff06374E).withOpacity(0.80),
                    ),
                    containerColor: const Color(0xffF6FAFD)),
                ContainerStatistics(
                    statisticsName: 'عدد المنتجات',
                    statisticsNumber: 876,
                    statisticsIcon: Icon(
                      Icons.ssid_chart,
                      color: const Color(0xff06374E).withOpacity(0.80),
                    ),
                    containerColor: const Color(0xffF6FAFD)),
              ],
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.h),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('الاحصائيات',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  // InkWell(
                  //     onTap: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => const StorageScreen(),
                  //           ));
                  //     },
                  //     child: const Text(
                  //       'إدارة المخزون',
                  //       style: TextStyle(fontSize: 16, color: Colors.black38),
                  //     ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
