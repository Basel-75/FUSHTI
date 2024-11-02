import 'dart:developer';

import 'package:customer_app/screen/home/cubit/home_cubit.dart';
import 'package:customer_app/screen/home/home_screen.dart';
import 'package:customer_app/screen/order_cart/order_cart_screen.dart';
import 'package:customer_app/screen/plan/add_plan_screen.dart';
import 'package:customer_app/screen/plan/cubit/plan_cubit/plan_cubit.dart';
import 'package:customer_app/screen/plan/plan_cart_screen.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/container/plan_item_container.dart';
import 'package:customer_app/widget/container/profile_small_container.dart';
import 'package:customer_app/widget/container/screen_header.dart';
import 'package:customer_app/widget/textFormFeild/custom_text_form_felid.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlanCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<PlanCubit>();
        return BlocListener<PlanCubit, PlanState>(
          listener: (context, state) {
            if (state is NoInterState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('لا يوجد الانترنت'),
                backgroundColor: Colors.red,
              ));
            }

            if (state is EorrPlanState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.msg),
                backgroundColor: Colors.red,
              ));
            }

            if (state is LodingState) {
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

            if (state is NoLodingState) {
              Navigator.pop(context);
            }

            if (state is ToCartState) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return PlanCartScreen(
                    planModel: cubit.planModelSelcted!,
                  );
                },
              ));
            }

            if (state is PlanChnageState) {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.msg),
                backgroundColor: Colors.green,
              ));
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.wallet,
                    color: Colors.white,
                  ),
                  Text(
                    '${cubit.appModel.userModel?.funds.toString()}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              title: Image.asset('assets/image/mainLogo.png'),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: const ShapeDecoration(
                  shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius.only(
                    bottomLeft:
                        SmoothRadius(cornerRadius: 50, cornerSmoothing: 0.1),
                    bottomRight:
                        SmoothRadius(cornerRadius: 50, cornerSmoothing: 0.1),
                  )),
                  color: Color(0xff6FBAE5),
                ),
              ),
              toolbarHeight: 15.h,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                log("${cubit.childModelSelcted}");
                if (cubit.isThereChild()) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                          width: 25.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: kElevationToShadow[8]),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: CustomTextFormFelid(
                                    controller: cubit.planNameCOn,
                                    label: "اضف خطة",
                                    hintText: "اسم الخطة",
                                    isPassword: false),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              CustomButton(
                                backgroundColor: Color(0xffC8E5F5),
                                onPressed: () {
                                  cubit.addPlan();
                                },
                                title: "تأكيد",
                                fixedSize: Size(30.w, 5.h),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'التابعين',
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff546F66)),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: BlocBuilder<PlanCubit, PlanState>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    CustomRadioButton(
                                      height: 5.h,
                                      width: 30.w,
                                      unSelectedBorderColor: Colors.grey,
                                      customShape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      enableShape: true,
                                      elevation: 2,
                                      unSelectedColor: const Color(0xffffffff),
                                      buttonLables: List.generate(
                                        cubit.appModel.userModel!.childModelList
                                            .length,
                                        (index) {
                                          return cubit.appModel.userModel!
                                              .childModelList[index].name;
                                        },
                                      ),
                                      buttonValues: List.generate(
                                        cubit.appModel.userModel!.childModelList
                                            .length,
                                        (index) {
                                          return cubit.appModel.userModel!
                                              .childModelList[index];
                                        },
                                      ),
                                      buttonTextStyle: ButtonTextStyle(
                                          selectedColor: Colors.black,
                                          unSelectedColor: Colors.black,
                                          textStyle:
                                              TextStyle(fontSize: 16.sp)),
                                      radioButtonValue: (value) {
                                        log("$value");

                                        cubit.clickInChild(childModel: value);
                                      },
                                      selectedColor: const Color.fromARGB(
                                          56, 12, 154, 236),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Text(
                            'الخطط',
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff546F66)),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: BlocBuilder<PlanCubit, PlanState>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    CustomRadioButton(
                                      height: 5.h,
                                      width: 30.w,

                                      customShape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      enableShape: true,
                                      elevation: 2,
                                      //absoluteZeroSpacing: true,
                                      unSelectedColor: const Color(0xffffffff),
                                      buttonLables: List.generate(
                                        cubit.planListUi.length,
                                        (index) {
                                          return cubit.planListUi[index].name!;
                                        },
                                      ),
                                      buttonValues: List.generate(
                                        cubit.planListUi.length,
                                        (index) {
                                          return cubit.planListUi[index];
                                        },
                                      ),
                                      buttonTextStyle: ButtonTextStyle(
                                          selectedColor: Colors.black,
                                          unSelectedColor: Colors.black,
                                          textStyle:
                                              TextStyle(fontSize: 16.sp)),
                                      radioButtonValue: (value) {
                                        log("$value");

                                        cubit.clickPlanState(planModel: value);
                                      },
                                      selectedColor: const Color.fromARGB(
                                          56, 12, 154, 236),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          BlocBuilder<PlanCubit, PlanState>(
                            builder: (context, state) {
                              return Row(
                                children: [
                                  Text(
                                    'الاطعمة المخصصة',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff546F66)),
                                  ),
                                  const Spacer(
                                    flex: 2,
                                  ),
                                  cubit.planModelSelcted != null
                                      ? GestureDetector(
                                          onTap: () {
                                            log("clecik del");
                                            cubit.delPlan();
                                          },
                                          child: const Icon(Icons.delete,color: Colors.red,))
                                      : const SizedBox(),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  cubit.planModelSelcted != null
                                      ? GestureDetector(
                                          child:
                                              const Icon(Icons.edit_outlined,color: Color(0xffA3E9BF),),
                                          onTap: () {
                                            log("in edit ");

                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  child: Container(
                                                    width: 30.w,
                                                    height: 30.h,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        boxShadow:
                                                            kElevationToShadow[
                                                                8]),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        CustomTextFormFelid(
                                                            controller: cubit
                                                                .planNameCOn,
                                                            label: "عدل خطة",
                                                            hintText:
                                                                "اسم الخطة",
                                                            isPassword: false),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        CustomButton(
                                                          onPressed: () {
                                                            cubit.editPlan();
                                                          },
                                                          title: "عدل",
                                                          fixedSize:
                                                              Size(30.w, 5.h),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        )
                                      : const SizedBox(),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                ],
                              );
                            },
                          ),
                          const Divider(),
                          SizedBox(
                            height: 45.h,
                            child: BlocBuilder<PlanCubit, PlanState>(
                              builder: (context, state) {
                                return GridView.builder(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.h, horizontal: 1.h),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.7,
                                  ),
                                  itemCount: cubit.mealPlanItemLisUi.length,
                                  itemBuilder: (context, index) =>
                                      PlanItemContainer(
                                    itemName: cubit.mealPlanItemLisUi[index]
                                        .foodMenuModel.foodName,
                                    imagePath: 'assets/image/lez.png',
                                    onDelete: () {
                                      log("on del method");
                                      cubit.delPlanItem(
                                          mealPlanItemModel:
                                              cubit.mealPlanItemLisUi[index]);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          const Divider(),
                          Center(
                              child: CustomButton(
                                  onPressed: () {
                                    cubit.toCart();
                                  },
                                  title: 'الدفع'))
                        ],
                      ),
                    ),
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
