import 'dart:developer';

import 'package:customer_app/screen/bottomnavigator/bottom_navigator_screen.dart';
import 'package:customer_app/screen/plan/cubit/plan_cart_cubit/plan_cart_cubit.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/container/add_plan_card.dart';
import 'package:customer_app/widget/container/pay_plan_bottom.dart';
import 'package:customer_app/widget/container/product_small_container.dart';
import 'package:customer_app/widget/devider/custom_dot_line.dart';
import 'package:customer_app/widget/row/cal_row.dart';
import 'package:customer_app/widget/row/item_details.dart';
import 'package:customer_app/widget/row/plan_date_row.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/get_all_pkg.dart';
import 'package:get_all_pkg/helper/format_date.dart';

class PlanCartScreen extends StatelessWidget {
  final PlanModel planModel;

  const PlanCartScreen({super.key, required this.planModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlanCartCubit(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Builder(builder: (context) {
          final cubit = context.read<PlanCartCubit>();
          return BlocListener<PlanCartCubit, PlanCartState>(
            listener: (context, state) {
              if (state is ErorrState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.msg),
                  backgroundColor: Colors.red,
                ));
              }

              if (state is LodingState) {
                showLoadingDialog(context: context);
              }

              if (state is DoneState) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("تم الدفع"),
                  backgroundColor: Colors.green,
                ));
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return const BottomNavigatorScreen();
                  },
                ));
              }
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                title: Text(
                  'دفع الخطة',
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
              body: Center(
                child: Column(
                  children: [
                    BlocBuilder<PlanCartCubit, PlanCartState>(
                      builder: (context, state) {
                        return TableCalendar(
                          rangeStartDay: cubit.startDate,
                          rangeEndDay: cubit.endDate,
                          headerVisible: false,
                          locale: 'en_US',
                          firstDay: DateTime.now(),
                          lastDay: DateTime(2024, 12, 31),
                          focusedDay: cubit.focusedDay, // Managed by Cubit

                          selectedDayPredicate: (day) {
                            // Use this to determine which day is currently selected.

                            return isSameDay(cubit.focusedDay, day);
                          },

                          onDaySelected: (selectedDay, focusedDay) {
                            cubit.focusedDay = selectedDay;

                            log("${cubit.focusedDay}");

                            cubit.upDateDate();
                          },
                          rangeSelectionMode: RangeSelectionMode
                              .toggledOn, // Enable range selection

                          calendarFormat:
                              CalendarFormat.week, // Show single row (week)
                          startingDayOfWeek: StartingDayOfWeek.sunday,
                          onRangeSelected: (start, end, focusedDay) {
                            cubit.dateRange(
                                start: start, end: end, day: focusedDay);
                          },
                          enabledDayPredicate: (day) {
                            bool isWeekend = day.weekday == DateTime.saturday ||
                                day.weekday == DateTime.sunday;

                            bool isHoliday = cubit.holidays.any((holiday) =>
                                holiday.year == day.year &&
                                holiday.month == day.month &&
                                holiday.day == day.day);

                            return !isWeekend && !isHoliday;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'الخطة',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 37.h,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: BlocBuilder<PlanCartCubit, PlanCartState>(
                          builder: (context, state) {
                            return Column(
                              children: List.generate(
                                planModel.mealPlanItemLis.length,
                                (index) {
                                  return AddPlanCard(
                                    productName: planModel
                                        .mealPlanItemLis[index]
                                        .foodMenuModel
                                        .foodName,
                                    cal: planModel.mealPlanItemLis[index]
                                        .foodMenuModel.cal
                                        .toString(),
                                    price: planModel.mealPlanItemLis[index]
                                        .foodMenuModel.price
                                        .toString(),
                                    quantity: planModel
                                        .mealPlanItemLis[index].quantity
                                        .toString(),
                                    imagePath: 'assets/image/boxImage.png',
                                    onAdd: () {
                                      cubit.onAdd(
                                          mealPlanItemModel:
                                              planModel.mealPlanItemLis[index]);
                                    },
                                    onMinus: () {
                                      cubit.onMinus(
                                          mealPlanItemModel:
                                              planModel.mealPlanItemLis[index]);
                                    },
                                    withoutDelete: true,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const CustomDotLine(),
                    SizedBox(
                      height: 1.h,
                    ),
                    SizedBox(
                      height: 17.h,
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
                              BlocBuilder<PlanCartCubit, PlanCartState>(
                                builder: (context, state) {
                                  return Column(
                                      children: planModel.mealPlanItemLis.map(
                                    (e) {
                                      return ItemDetails(
                                        productName: e.foodMenuModel.foodName,
                                        price:
                                            (e.foodMenuModel.price * e.quantity)
                                                .toString(),
                                        quantity: e.quantity.toString(),
                                      );
                                    },
                                  ).toList());
                                },
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              BlocBuilder<PlanCartCubit, PlanCartState>(
                                builder: (context, state) {
                                  return PlanDateRow(
                                    startDate: formatDate(cubit.startDate) ??
                                        "لم يحدد",
                                    endDate:
                                        formatDate(cubit.endDate) ?? "لم يحدد",
                                  );
                                },
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
                                  const Spacer(),
                                  BlocBuilder<PlanCartCubit, PlanCartState>(
                                    builder: (context, state) {
                                      return Text(
                                        '${cubit.dayNume} أيام',
                                        style: TextStyle(fontSize: 13.sp),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              BlocBuilder<PlanCartCubit, PlanCartState>(
                                builder: (context, state) {
                                  return CalRow(
                                    totalCal: cubit.calculateCal(
                                        planModel: planModel),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    BlocBuilder<PlanCartCubit, PlanCartState>(
                      builder: (context, state) {
                        return PayPlanBottom(
                          totalPrice:
                              cubit.calculateTotal(planModel: planModel),
                          onPressed: () {
                            cubit.payPlan(planModel: planModel);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
