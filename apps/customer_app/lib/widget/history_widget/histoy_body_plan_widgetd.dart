import 'package:customer_app/widget/history_widget/bottom_info.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

import 'content_history.dart';

class HistoryBodyPlanWidget extends StatelessWidget {
  const HistoryBodyPlanWidget(
      {super.key, required this.planLis, this.childModel});

  final List<PlanModel> planLis;

  final ChildModel? childModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: planLis.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                //change it
                planLis[index].createDate,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Container(
              width: 94.w,
              decoration: BoxDecoration(
                  boxShadow: kElevationToShadow[2],
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffffffff)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.7.h, vertical: 4.w),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: planLis[index].mealPlanItemLis.length,
                      itemBuilder: (context, itemIndex) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ContentHistory(
                              isBill: false,
                              image: "assets/image/egg.png",
                              foodName: planLis[index]
                                  .mealPlanItemLis[itemIndex]
                                  .foodMenuModel
                                  .foodName,
                              numberOfCal: planLis[index]
                                  .mealPlanItemLis[itemIndex]
                                  .foodMenuModel
                                  .cal,
                              quantity: planLis[index]
                                  .mealPlanItemLis[itemIndex]
                                  .quantity,
                              price:
                                  "${(planLis[index].mealPlanItemLis[itemIndex].foodMenuModel.price * (planLis[index].mealPlanItemLis[itemIndex].quantity))}",
                            ),
                            SizedBox(
                                height: index < planLis.length - 1 ? 2.h : 0),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    BottomHistoryInfo(
                      isForPlan: true,
                      startPlan: planLis[index].startDate,
                      endPlan: planLis[index].endDate,
                      totalPrice: "",
                      name: childModel?.name ?? planLis[index].childModel!.name,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
