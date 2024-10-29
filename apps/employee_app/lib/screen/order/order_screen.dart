import 'dart:developer';

import 'package:employee_app/component/drop_down_item.dart';
import 'package:employee_app/screen/order/cubit/order_cubit.dart';
import 'package:employee_app/widget/appbar_emp_header.dart';
import 'package:employee_app/widget/button/custome_button.dart';
import 'package:employee_app/widget/container/card_storage.dart';
import 'package:employee_app/widget/container/cardorder.dart';
import 'package:employee_app/widget/container/container_funds.dart';
import 'package:employee_app/widget/dropDownList/custome_multi_select.dart';
import 'package:employee_app/widget/textTitle/title_name.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class OrderScreen extends StatelessWidget {
  final ChildModel childModel;
  const OrderScreen({super.key, required this.childModel});

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
        'status': false,
      },
    ];
    return BlocProvider(
      create: (context) => OrderCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<OrderCubit>();

        cubit.childModel = childModel;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(19.h),
              child: AppBar(
                flexibleSpace: EmployeeHeader(
                  isTitle: true,
                  title: 'الطلبات',
                  textSize: 20.sp,
                ),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 3.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        'assets/image/child_img.png',
                        width: 40.w,
                        height: 17.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'روان احمد',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '٢/ب',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.brown,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ContainerFunds(label: 'المصروف', amount: "22"),
                        SizedBox(width: 20),
                        ContainerFunds(label: 'الحد اليومي', amount: "33"),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    CustomMultiSelect(
                      label: 'الاختيارات',
                      hintText: 'اختر الوجبات',
                      items: const [],
                      onListChanged: (val) {},
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    EmpTitleName(
                      paddingTop: 0.6.h,
                      paddingRight: 2.h,
                      textSize: 16.sp,
                      schoolName: 'قائمة الطعام',
                    ),
                    SizedBox(
                      height: 40.h,
                      child: BlocBuilder<OrderCubit, OrderState>(
                        builder: (context, state) {
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              var feedBack = data[index];
                              return CardOrder(
                                onAdd: () {},
                                onMinus: () {},
                                quantity: feedBack['description'],
                                image: feedBack['image'],
                                name: feedBack['name'],
                                isOpenDays: false,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    CustomButton(
                        onPressed: () {
                          cubit.getAllCHildOrder();
                        },
                        title: "تأكيد الطلب")
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
