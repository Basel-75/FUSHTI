import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/container/product_small_container.dart';
import 'package:customer_app/widget/coulmn/product_info_column.dart';
import 'package:customer_app/widget/dropDownMenu/custom_multi_select.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffFFFFFF), Color(0xffE0D1BB)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              width: 100.w,
              //height: 44.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffFFFFFF), Color(0xffE0D1BB)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/image/boxImage.png',
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: const Row(
                      children: [
                        // BoxItemContainer(
                        //   itemName: 'ليز',
                        //   imagePath: 'assets/image/lez.png',
                        // ),
                        // BoxItemContainer(
                        //   itemName: 'ليز',
                        //   imagePath: 'assets/image/lez.png',
                        // ),
                        // BoxItemContainer(
                        //   itemName: 'ليز',
                        //   imagePath: 'assets/image/lez.png',
                        // ),
                        // BoxItemContainer(
                        //   itemName: 'ليز',
                        //   imagePath: 'assets/image/lez.png',
                        // ),
                        // BoxItemContainer(
                        //   itemName: 'ليز',
                        //   imagePath: 'assets/image/lez.png',
                        // ),
                        // BoxItemContainer(
                        //   itemName: 'ليز',
                        //   imagePath: 'assets/image/lez.png',
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    boxShadow: kElevationToShadow[4]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductInfoColumn(
                      productName: 'بوكس السعادة',
                      description: 'هذه الوجبة تحتوي على لوزين, تمر عسل,كورنفلكس والمزيد من المفرحات',
                      rate: '4.8',
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProductSmallContainer(
                          isForCal: true,
                          amount: '200',
                          isCallWithText: true,
                        ),
                        ProductSmallContainer(
                          isForCal: false,
                          amount: '18',
                          isCallWithText: false,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'تحديد الوجبة للتابع',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.sp),
                    ),
                    CustomMultiSelect(label: '', hintText: 'اختر التابع',items: [],),
                    SizedBox(
                      height: 2.h,
                    ),
                    Spacer(),
                    Center(
                      child:
                          CustomButton(onPressed: () {}, title: 'اضافة الوجبة'),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
