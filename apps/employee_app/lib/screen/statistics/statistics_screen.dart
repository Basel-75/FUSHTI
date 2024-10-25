import 'package:employee_app/screen/add_product/add_product_screen.dart';
import 'package:employee_app/screen/feedback/feedback_screen.dart';
import 'package:employee_app/screen/storage/storage_product_screen.dart';
import 'package:employee_app/widget/appbar_emp_header.dart';
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
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (builder) {
                    return const FeedBackScreen();
                  }));
                },
                icon: const Icon(Icons.chat_outlined)),
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
            SizedBox(
              height: 2.h,
            ),
            EmpTitleName(
              paddingTop: 0.h,
              paddingRight: 4.h,
              textSize: 18.sp,
              schoolName: 'أحصائياتي',
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ContainerStatistics(
                    containerHeight: 11.h,
                    containerWidth: 30.w,
                    statisticsName: 'الدخل',
                    statisticsNumber: 876,
                    statisticsIcon: const Icon(
                      Icons.monetization_on,
                      color: Color(0xffA8483D),
                    ),
                    statisticsNameTxtSize: 16.sp,
                    statisticsNumberTxtSize: 14.sp,
                    txtColor: Colors.black,
                    containerColor: const Color(0xffE0D1BB).withOpacity(0.80)),
                ContainerStatistics(
                    containerHeight: 11.h,
                    containerWidth: 30.w,
                    statisticsName: 'الدخل',
                    statisticsNumber: 876,
                    statisticsIcon: const Icon(Icons.monetization_on),
                    statisticsNameTxtSize: 16.sp,
                    statisticsNumberTxtSize: 14.sp,
                    txtColor: Colors.black,
                    containerColor: const Color(0xffE0D1BB).withOpacity(0.80)),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ContainerStatistics(
                    containerHeight: 11.h,
                    containerWidth: 30.w,
                    statisticsName: 'الدخل',
                    statisticsNumber: 876,
                    statisticsIcon: const Icon(Icons.monetization_on),
                    statisticsNameTxtSize: 16.sp,
                    statisticsNumberTxtSize: 14.sp,
                    txtColor: Colors.black,
                    containerColor: const Color(0xffE0D1BB).withOpacity(0.80)),
                ContainerStatistics(
                    containerHeight: 11.h,
                    containerWidth: 30.w,
                    statisticsName: 'الدخل',
                    statisticsNumber: 876,
                    statisticsIcon: const Icon(Icons.monetization_on),
                    statisticsNameTxtSize: 16.sp,
                    statisticsNumberTxtSize: 14.sp,
                    txtColor: Colors.black,
                    containerColor: const Color(0xffE0D1BB).withOpacity(0.80)),
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
                              builder: (context) => StorageScreen(),
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

class ContainerStatistics extends StatelessWidget {
  const ContainerStatistics({
    super.key,
    required this.statisticsName,
    required this.statisticsNumber,
    required this.statisticsIcon,
    required this.statisticsNameTxtSize,
    required this.statisticsNumberTxtSize,
    required this.txtColor,
    required this.containerColor,
    required this.containerWidth,
    required this.containerHeight,
  });

  final String statisticsName;
  final int statisticsNumber;
  final Icon statisticsIcon;
  final double statisticsNameTxtSize;
  final double statisticsNumberTxtSize;
  final Color txtColor;
  final Color containerColor;
  final double containerWidth;
  final double containerHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: containerColor,
        border: Border.all(width: 0.2, color: Colors.black26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              statisticsName,
              style:
                  TextStyle(fontSize: statisticsNameTxtSize, color: txtColor),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.money),
                Text(
                  '$statisticsNumber',
                  style: TextStyle(
                      color: txtColor, fontSize: statisticsNumberTxtSize),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
