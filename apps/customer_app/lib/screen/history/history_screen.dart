import 'dart:developer';

import 'package:customer_app/screen/history/cubit/history_cubit.dart';
import 'package:customer_app/screen/product/cubit/product_cubit.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/history_widget/bottom_info.dart';
import 'package:customer_app/widget/history_widget/content_history.dart';
import 'package:customer_app/widget/history_widget/histoy_body_order_widget.dart';
import 'package:customer_app/widget/history_widget/histoy_body_plan_widgetd.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //replace it with Bloc

    //replace it with Bloc order.length
    const int orderNum = 3;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => HistoryCubit()..historyBring(),
        child: Builder(builder: (context) {
          final cubit = context.read<HistoryCubit>();

          return BlocListener<HistoryCubit, HistoryState>(
            listener: (context, state) {
              if (state is ErorrState) {
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
                log("in lodaing");
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
                log("very good history");
              }
            },
            child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'سجل الطلبات',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
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
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 3.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomRadioButton(
                              buttonTextStyle: const ButtonTextStyle(
                                  selectedColor: Colors.white,
                                  unSelectedColor: Colors.black,
                                  textStyle: TextStyle(fontSize: 16)),
                              enableShape: true,
                              elevation: 0,
                              customShape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              buttonLables: ["plan", "order"],
                              buttonValues: ["plan", "order"],
                              unSelectedColor: const Color(0xffe5dfcf),
                              selectedColor: Colors.blueAccent,
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
                                  ? HistoyBodyOrderWidget(
                                      lisOrder: cubit.lisOrder)
                                  : HistoyBodyPlanWidgetd(
                                      planLis: cubit.planLis);
                            },
                          )),
                    ],
                  ),
                )
                // : Center(
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Image.asset('assets/image/history_img.png'),
                //         SizedBox(
                //           height: 2.h,
                //         ),
                //         const Text(
                //           "ليس لديك طلبات :(",
                //           style: TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.bold,
                //               fontFamily: 'Rosarivo',
                //               color: Colors.black),
                //         ),
                //         CustomButton(onPressed: () {}, title: 'اطلب الأن'),
                //         SizedBox(
                //           height: 15.h,
                //         )
                //       ],
                //     ),
                //   ),
                ),
          );
        }),
      ),
    );
  }
}
