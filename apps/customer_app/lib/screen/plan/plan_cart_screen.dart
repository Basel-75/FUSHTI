import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/container/add_plan_card.dart';
import 'package:customer_app/widget/container/product_small_container.dart';
import 'package:customer_app/widget/devider/custom_dot_line.dart';
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
                height: 30.h,
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

class PayPlanBottom extends StatelessWidget {
  final String totalPrice;
  final void Function() onPressed;
  const PayPlanBottom({
    super.key,
    required this.totalPrice,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'المجموع',
                style: TextStyle(fontSize: 16.sp),
              ),
              const Spacer(),
              Text(
                '$totalPrice رس',
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          CustomButton(onPressed: onPressed, title: 'دفع'),
        ],
      ),
    );
  }
}

class CalRow extends StatelessWidget {
  final String totalCal;
  const CalRow({
    super.key,
    required this.totalCal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'عدد السعرات',
          style: TextStyle(fontSize: 13.sp),
        ),
        Spacer(),
        Text(
          '$totalCal سعرة',
          style: TextStyle(fontSize: 13.sp),
        ),
        Icon(
          Icons.local_fire_department,
          color: Color(0xffE4A951),
        )
      ],
    );
  }
}

class PlanDateRow extends StatelessWidget {
  final String startDate, endDate;
  const PlanDateRow({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'تاريخ الخطة',
          style: TextStyle(fontSize: 13.sp),
        ),
        Spacer(),
        Text(
          '  من $startDate  الى $endDate ',
          style: TextStyle(fontSize: 13.sp),
        ),
      ],
    );
  }
}

class ItemDetails extends StatelessWidget {
  final String productName, quantity, price;
  const ItemDetails({
    super.key,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        children: [
          Text(
            productName,
            style: TextStyle(fontSize: 13.sp),
          ),
          const Spacer(),
          Text(
            '$quantity X',
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 13.sp),
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            '$price رس',
            style: TextStyle(fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
