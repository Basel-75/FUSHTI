import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/container/add_plan_card.dart';
import 'package:customer_app/widget/container/pay_plan_bottom.dart';
import 'package:customer_app/widget/container/product_small_container.dart';
import 'package:customer_app/widget/devider/custom_dot_line.dart';
import 'package:customer_app/widget/row/cal_row.dart';
import 'package:customer_app/widget/row/item_details.dart';
import 'package:customer_app/widget/row/plan_date_row.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class PlanCartScreen extends StatelessWidget {
  const PlanCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'دفع الخطة',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          actions: [
            Image.asset('assets/image/homeicon.png'),
            SizedBox(
              width: 2.h,
            )
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffFEFEFD), Color(0xffE0D1BB)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                )),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              // SfDateRangePicker(
              //   view: DateRangePickerView.month,
              //   selectionMode: DateRangePickerSelectionMode.range,
              //   showNavigationArrow: true,
              //   enableMultiView: false, // Single view in horizontal row

              //   selectionShape: DateRangePickerSelectionShape.rectangle,
              //   headerStyle: DateRangePickerHeaderStyle(
              //     textAlign: TextAlign.center, // Center header text
              //   ),
              //   navigationDirection: DateRangePickerNavigationDirection
              //       .horizontal, // Horizontal scro
              // ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                'الخطة',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 37.h,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Column(
                    children: [
                      AddPlanCard(
                        productName: 'بوكس السعادة',
                        cal: '150',
                        price: '12',
                        quantity: '1',
                        imagePath: 'assets/image/boxImage.png',
                        onAdd: () {},
                        onMinus: () {},
                        withoutDelete: true,
                      ),
                    ],
                  ),
                ),
              ),
              const CustomDotLine(),
              SizedBox(
                height: 1.h,
              ),
              SizedBox(
                height: 22.h,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        const Text('الطلبات'),
                        SizedBox(
                          height: 1.h,
                        ),
                        //coulmn for order
                        const Column(
                          children: [
                            ItemDetails(
                              productName: 'بوكس السعادة',
                              price: '12',
                              quantity: '2',
                            ),
                            ItemDetails(
                              productName: 'بوكس السعادة',
                              price: '12',
                              quantity: '2',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        PlanDateRow(
                          startDate: '2024/10/5',
                          endDate: '2024/10/9',
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'عدد الأيام',
                              style: TextStyle(fontSize: 13.sp),
                            ),
                            Spacer(),
                            Text(
                              '4 أيام',
                              style: TextStyle(fontSize: 13.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CalRow(
                          totalCal: '120',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              PayPlanBottom(
                totalPrice: '24',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
