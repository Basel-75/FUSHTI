import 'dart:developer';

import 'package:customer_app/component/drop_down_item.dart';
import 'package:customer_app/screen/product/cubit/product_cubit.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/container/product_small_container.dart';
import 'package:customer_app/widget/coulmn/product_info_column.dart';
import 'package:customer_app/widget/dropDownMenu/custom_multi_select.dart';
import 'package:customer_app/widget/dropDownMenu/custom_select.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ProductScreen extends StatelessWidget {
  final FoodMenuModel foodMenuModel;
  final ChildModel childModel;

  const ProductScreen({
    super.key,
    required this.foodMenuModel,
    required this.childModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(foodMenuModel, childModel),
      child: Builder(builder: (context) {
        final cubit = context.read<ProductCubit>();
        log('${childModel.toJson()}|${foodMenuModel.toJson()}');
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BlocListener<ProductCubit, ProductState>(
            listener: (context, state) {
              if (state is DoneAddState) {
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('product has been add to the cart'),
                  backgroundColor: Colors.green,
                ));
              }

              if (state is CartThereState) {
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('you arldy add to the cart'),
                  backgroundColor: Colors.red,
                ));
              }

              if (state is EorrState) {
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.msg),
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,

                // flexibleSpace: Container(
                //   decoration: const BoxDecoration(
                //     gradient: LinearGradient(
                //       colors: [Color(0xffFFFFFF), Color(0xffE0D1BB)],
                //       begin: Alignment.bottomCenter,
                //       end: Alignment.topCenter,
                //     ),
                //   ),
                // ),
              ),
              body: Column(
                children: [
                  Container(
                    width: 100.w,
                    //height: 44.h,
                    decoration: const BoxDecoration(
                        // gradient: LinearGradient(
                        //   colors: [Color(0xffFFFFFF), Color(0xffE0D1BB)],
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        // ),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 100.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          boxShadow: kElevationToShadow[4]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductInfoColumn(
                            productName: foodMenuModel.foodName,
                            description: foodMenuModel.description ?? "",
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ProductSmallContainer(
                                isForCal: true,
                                amount: foodMenuModel.cal.toString(),
                                isCallWithText: true,
                              ),
                              ProductSmallContainer(
                                isForCal: false,
                                amount: foodMenuModel.price.toString(),
                                isCallWithText: false,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          const Spacer(),
                          Center(
                            child: CustomButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Builder(builder: (context) {
                                          return Container(
                                            width: 50.w,
                                            height: 25.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow:
                                                    kElevationToShadow[8],
                                                color: Colors.white),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                CustomSelect(
                                                    onChanged: (p0) {
                                                      log("$p0");

                                                      cubit.planItemCOn.text =
                                                          p0!.name;
                                                    },
                                                    items: List.generate(
                                                      childModel
                                                          .planList.length,
                                                      (index) {
                                                        return DropDownItem(
                                                            childModel
                                                                .planList[index]
                                                                .name!);
                                                      },
                                                    ),
                                                    label: "الخطة",
                                                    hintText: "enter"),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    CustomButton(
                                                        fontsize: 15.sp,
                                                        backgroundColor:
                                                            Color(0xffC8E5F5),
                                                        fixedSize:
                                                            Size(30.w, 6.h),
                                                        onPressed: () {
                                                          cubit.addToCart(
                                                              childModel:
                                                                  childModel,
                                                              foodMenuModel:
                                                                  foodMenuModel);
                                                        },
                                                        title: "اضافة لسلة"),
                                                    CustomButton(
                                                        fontsize: 15.sp,
                                                        backgroundColor:
                                                            Color(0xffA3E9BF),
                                                        fixedSize:
                                                            Size(32.w, 6.h),
                                                        onPressed: () {
                                                          cubit.addToPlan();
                                                        },
                                                        title: "اضافة للخطة")
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                  );
                                },
                                title: 'اضافة'),
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
          ),
        );
      }),
    );
  }
}
