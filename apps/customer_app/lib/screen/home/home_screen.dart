import 'dart:developer';

import 'package:customer_app/screen/home/cubit/home_cubit.dart';
import 'package:customer_app/screen/product/product_screen.dart';
import 'package:customer_app/widget/avatar/followers_avatar.dart';
import 'package:customer_app/widget/container/home_card.dart';
import 'package:customer_app/widget/container/screen_header.dart';
import 'package:customer_app/widget/coulmn/child_avatar.dart';
import 'package:customer_app/widget/row/app_bar_row_button.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<HomeCubit>();
        cubit.initHome();
        return Scaffold(
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return ScreenHeader(
                        childModel: cubit.currentChild,
                        childSchollName: cubit.currentChild.schoolModel.name,
                        funds: cubit.appModel.userModel!.funds.toString(),
                        inHomeScreen: true,
                        parentName: cubit.appModel.userModel!.name,
                        //title use if isHomeScreen = false
                        title: '',
                      );
                    },
                  ),
                  //?=========Header End================
                  SizedBox(
                    height: 1.h,
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'التابعين',
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(
                                  cubit.childModelList.length,
                                  (index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: FollowersAvatar(
                                        onTap: () {
                                          log("chnageChild start");
                                          cubit.chnageChild(
                                              cubit.childModelList[index]);
                                        },
                                        childImage: 'assets/image/kid1.png',
                                        childName:
                                            cubit.childModelList[index].name,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          'الأفضل مبيعا',
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(vertical: 1.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(
                                  cubit.currentChild.schoolModel
                                      .foodMenuModelList.length,
                                  (index) {
                                    return HomeCard(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return ProductScreen(

                                              childModel:  cubit.currentChild,
                                              foodMenuModel:  cubit.currentChild.schoolModel
                                          .foodMenuModelList[index],
                                           
                                            );
                                          },
                                        ));
                                      },
                                      cal: cubit.currentChild.schoolModel
                                          .foodMenuModelList[index].cal,
                                      imagePath: 'assets/image/lez.png',
                                      itemName: cubit.currentChild.schoolModel
                                          .foodMenuModelList[index].foodName,
                                      price: cubit
                                          .currentChild
                                          .schoolModel
                                          .foodMenuModelList[index]
                                          .price as double,
                                      rate: '4.8',
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        const Text(
                          'أقسامنا',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xffe7c7c5)),
                                  child:
                                      Image.asset('assets/image/breakfast.png'),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xffe7c7c5)),
                                  child: Image.asset('assets/image/launch.png'),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 129,
                                  height: 75,
                                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xffd7bf9c)),
                                  child: Image.asset('assets/image/snack.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        const Text(
                          'البوكسات',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              HomeCard(
                                cal: 30,
                                imagePath: 'assets/image/lez.png',
                                itemName: 'بوكس السعادة',
                                price: 2,
                                rate: '4.8',
                              ),
                              HomeCard(
                                cal: 30,
                                imagePath: 'assets/image/lez.png',
                                itemName: 'بوكس التغذية',
                                price: 2,
                                rate: '4.8',
                              ),
                              HomeCard(
                                cal: 30,
                                imagePath: 'assets/image/lez.png',
                                itemName: 'بوكس المفرحات',
                                price: 2,
                                rate: '4.8',
                              ),
                              HomeCard(
                                cal: 30,
                                imagePath: 'assets/image/lez.png',
                                itemName: 'ليز',
                                price: 2,
                                rate: '4.8',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Text(
                    'الوجبات',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          cal: 30,
                          imagePath: 'assets/image/lez.png',
                          itemName: 'ليز',
                          price: 2,
                          rate: '4.8',
                        ),
                        HomeCard(
                          cal: 30,
                          imagePath: 'assets/image/lez.png',
                          itemName: 'ليز',
                          price: 2,
                          rate: '4.8',
                        ),
                        HomeCard(
                          cal: 30,
                          imagePath: 'assets/image/lez.png',
                          itemName: 'ليز',
                          price: 2,
                          rate: '4.8',
                        ),
                        HomeCard(
                          cal: 30,
                          imagePath: 'assets/image/lez.png',
                          itemName: 'ليز',
                          price: 2,
                          rate: '4.8',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
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
