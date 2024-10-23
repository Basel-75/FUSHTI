import 'dart:developer';

import 'package:customer_app/screen/home/home_screen.dart';
import 'package:customer_app/screen/plan/cubit/plan_cubit.dart';
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
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BlocListener<PlanCubit, PlanState>(
            listener: (context, state) {
              if (state is NoInterState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Please check your Internet'),
                  backgroundColor: Colors.red,
                ));
              }

              if (state is EorrPlanState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.msg),
                  backgroundColor: Colors.red,
                ));
              }

              if(state is LodingState){
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

              if(state is NoLodingState){
                   Navigator.pop(context);
              }
            },
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  log("${cubit.childModelSelcted}");
                  if (cubit.isThereChild()) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: kElevationToShadow[8]),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                CustomTextFormFelid(
                                    controller: cubit.planNameCOn,
                                    label: "اضف خطة",
                                    hintText: "اسم الخطة",
                                    isPassword: false),
                                SizedBox(
                                  height: 2.h,
                                ),
                                CustomButton(
                                  onPressed: () {
                                    cubit.addPlan();
                                  },
                                  title: "اضف",
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startFloat,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ScreenHeader(
                      parentName: '',
                      title: 'الخطط',
                      inHomeScreen: false,
                      funds: '',
                      childSchollName: '',
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'التابعين',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: BlocBuilder<PlanCubit, PlanState>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    CustomRadioButton(
                                      height: 10.h,

                                      customShape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      enableShape: true,
                                      elevation: 0,
                                      //absoluteZeroSpacing: true,
                                      unSelectedColor: const Color(0xffe5dfcf),
                                      // buttonLables: const [
                                      //   'احمد',
                                      //   'انس',
                                      //   'احمد',
                                      //   'خالد',
                                      // ],
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
                                      buttonTextStyle: const ButtonTextStyle(
                                          selectedColor: Colors.white,
                                          unSelectedColor: Colors.black,
                                          textStyle: TextStyle(fontSize: 16)),

                                      radioButtonValue: (value) {
                                        log("$value");

                                        cubit.clickInChild(childModel: value);
                                      },
                                      selectedColor: Colors.blueAccent,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const Text(
                            'الخطط',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: BlocBuilder<PlanCubit, PlanState>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    CustomRadioButton(
                                      height: 10.h,

                                      customShape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      enableShape: true,
                                      elevation: 0,
                                      //absoluteZeroSpacing: true,
                                      unSelectedColor: const Color(0xffe5dfcf),
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
                                      buttonTextStyle: const ButtonTextStyle(
                                          selectedColor: Colors.white,
                                          unSelectedColor: Colors.black,
                                          textStyle: TextStyle(fontSize: 16)),
                                      radioButtonValue: (value) {
                                        log("$value");

                                        cubit.clickPlanState(planModel: value);
                                      },
                                      selectedColor: Colors.blueAccent,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const Text(
                            'الاطعمة المخصصة',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                                  onPressed: () {}, title: 'الدفع'))
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
