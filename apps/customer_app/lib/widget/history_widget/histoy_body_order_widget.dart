import 'package:customer_app/widget/history_widget/bottom_info.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/order_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

import 'content_history.dart';

class HistoyBodyOrderWidget extends StatelessWidget {
  const HistoyBodyOrderWidget(
      {super.key, required this.lisOrder, this.childModel});

  final List<OrderModel> lisOrder;
  final ChildModel? childModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: lisOrder.length,
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
                lisOrder[index].createDate,
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
                      itemCount: lisOrder[index].orderItemModelLis.length,
                      itemBuilder: (context, itemIndex) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ContentHistory(
                              isBill: false,
                              image: "assets/image/egg.png",
                              foodName: lisOrder[index]
                                  .orderItemModelLis[itemIndex]
                                  .foodMenuModel
                                  .foodName,
                              numberOfCal: lisOrder[index]
                                  .orderItemModelLis[itemIndex]
                                  .foodMenuModel
                                  .cal,
                              quantity: lisOrder[index]
                                  .orderItemModelLis[itemIndex]
                                  .quantity,
                              price:
                                  "${(lisOrder[index].orderItemModelLis[itemIndex].foodMenuModel.price * (lisOrder[index].orderItemModelLis[itemIndex].quantity))}",
                            ),
                            SizedBox(
                                height: index < lisOrder.length - 1 ? 2.h : 0),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    BottomHistoryInfo(
                      totalPrice: lisOrder[index].totalPrice.toString(),
                      name:
                          childModel?.name ?? lisOrder[index].childModel!.name,
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
