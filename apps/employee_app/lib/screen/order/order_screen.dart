import 'dart:developer';

import 'package:employee_app/component/drop_down_item.dart';

import 'package:employee_app/screen/order/cubit/order_cubit/order_cubit.dart';

import 'package:employee_app/widget/appbar_emp_header.dart';
import 'package:employee_app/widget/button/custome_button.dart';
import 'package:employee_app/widget/container/card_storage.dart';
import 'package:employee_app/widget/container/cardorder.dart';
import 'package:employee_app/widget/container/container_funds.dart';
import 'package:employee_app/widget/dropDownList/custom_multi_select.dart';
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
    return BlocProvider(
      create: (context) => OrderCubit()
        ..childModel = childModel
        ..getAllCHildOrder(),
      child: Builder(builder: (context) {
        final cubit = context.read<OrderCubit>();

        log("why iam here ----------------------------------------------");

        // cubit.getAllCHildOrder();

        return Directionality(
          textDirection: TextDirection.rtl,
          child: BlocListener<OrderCubit, OrderState>(
            listener: (context, state) {
              if (state is ErorState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    state.msg,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.red,
                ));
              }

              if (state is LodingState) {
                log("in loding");
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              }

              if (state is DoneState) {
                Navigator.pop(context);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                title: Text(
                  'الطلبات',
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
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        'assets/image/child_img.png',
                        width: 40.w,
                        height: 17.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      cubit.childModel.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      cubit.childModel.studentClass,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.brown,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ContainerFunds(
                            backgroundColor:
                                const Color(0xffFBC983).withOpacity(0.56),
                            label: 'المصروف',
                            amount: cubit.childModel.funds.toString()),
                        BlocBuilder<OrderCubit, OrderState>(
                          builder: (context, state) {
                            return ContainerFunds(
                                backgroundColor:
                                    const Color(0xffFBC983).withOpacity(0.56),
                                label: 'الحد اليومي',
                                amount:
                                    "${cubit.childModel.dailyLimits}/${cubit.dailyLimitTotal + cubit.preDailyLimitTotal}");
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    CustomMultiSelects(
                      backgroundColor: const Color(0xffF6FAFD),
                      label: 'الاختيارات',
                      hintText: 'اختر الوجبات',
                      items: cubit.foodDropList,
                      onListChanged: (val) {
                        cubit.addFromDrop(dropList: val);
                      },
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
                    BlocBuilder<OrderCubit, OrderState>(
                      builder: (context, state) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cubit.scanLis.length,
                          itemBuilder: (context, index) {
                            return CardOrder(
                              onAdd: () {
                                cubit.queAdd(
                                    orderItem:
                                        cubit.scanLis[index].orderItemModel!);
                              },
                              onMinus: () {
                                cubit.queMin(
                                    orderItem:
                                        cubit.scanLis[index].orderItemModel!);
                              },
                              quantity: cubit
                                      .scanLis[index].orderItemModel?.quantity
                                      .toString() ??
                                  cubit.scanLis[index].que.toString(),
                              image: "assets/image/egg.png",
                              name: cubit.scanLis[index].foodMenuModel.foodName,
                              isOpenDays: cubit.scanLis[index].isDily,
                              price:
                                  "${(cubit.scanLis[index].orderItemModel?.foodMenuModel.price ?? 0) * (cubit.scanLis[index].orderItemModel?.quantity ?? 1)}",
                            );
                          },
                        );
                      },
                    ),
                    CustomButton(
                        onPressed: () {
                          cubit.checkOut();
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
