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
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: const Color(0xffC9E7E7),
          tooltip: 'Increment',
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
              return const AddProductScreen();
            }));
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            'الاحصائيات',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            height: 15.h,
            decoration: const BoxDecoration(
              color: Color(0xff6FBAE5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
          ),
          toolbarHeight: 13.h,
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
              paddingTop: 0.h,
              paddingRight: 4.h,
              textSize: 18.sp,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('الاحصائيات',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StorageScreen(),
                            ));
                      },
                      child: const Text(
                        'إدارة المخزون',
                        style: TextStyle(fontSize: 16, color: Colors.black38),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
