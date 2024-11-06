import 'dart:developer';

import 'package:customer_app/screen/history/cubit/history_cubit.dart';
import 'package:customer_app/widget/history_widget/histoy_body_order_widget.dart';
import 'package:customer_app/widget/history_widget/histoy_body_plan_widgetd.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => HistoryCubit()..historyBring(),
        child: Builder(builder: (context) {
          final cubit = context.read<HistoryCubit>();

          return BlocListener<HistoryCubit, HistoryState>(
            listener: (context, state) {
              if (state is ErrorState) {
                Navigator.pop(context);
                showSnackBar(context: context, msg: state.msg, isError: true);
              }

              if (state is LoadingState) {
                log("in loading");
                showLoadingDialog(context: context);
              }

              if (state is DoneState) {
                Navigator.pop(context);
                log("very good history");
              }
            },
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  title: Text(
                    'الفواتير',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  centerTitle: true,
                  flexibleSpace: Container(
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
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 3.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomRadioButton(
                              buttonTextStyle: ButtonTextStyle(
                                  selectedColor: Colors.black,
                                  unSelectedColor: Colors.black,
                                  textStyle: TextStyle(fontSize: 16.sp)),
                              enableShape: true,
                              elevation: 2,
                              customShape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              buttonLables: const ["خطة", "طلبات"],
                              buttonValues: const ["plan", "order"],
                              unSelectedColor: const Color(0xffffffff),
                              unSelectedBorderColor: Colors.grey,
                              selectedColor:
                                  const Color.fromARGB(56, 12, 154, 236),
                              defaultSelected: "order",
                              radioButtonValue: (p0) {
                                log(p0);
                                cubit.tabClick(tabName: p0);
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 2.h),
                          child: BlocBuilder<HistoryCubit, HistoryState>(
                            builder: (context, state) {
                              return cubit.isOrder == true
                                  ? HistoryBodyOrderWidget(
                                      lisOrder: cubit.lisOrder)
                                  : HistoryBodyPlanWidget(
                                      planLis: cubit.planLis);
                            },
                          )),
                    ],
                  ),
                )),
          );
        }),
      ),
    );
  }
}
