import 'dart:developer';

import 'package:customer_app/screen/home/cubit/home_cubit.dart';
import 'package:customer_app/screen/order_cart/order_cart_screen.dart';
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wallet,
                  color: Colors.white,
                ),
                Text(
                  '${cubit.appModel.userModel?.funds.toString()}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderCartScreen(childModel: HomeCubit.currentChild),
                      )),
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  )),
            ],
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
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
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
                                  HomeCubit.currentChild.schoolModel
                                      .foodMenuModelList.length,
                                  (index) {
                                    return HomeCard(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return ProductScreen(
                                              childModel:
                                                  HomeCubit.currentChild,
                                              foodMenuModel: HomeCubit
                                                  .currentChild
                                                  .schoolModel
                                                  .foodMenuModelList[index],
                                            );
                                          },
                                        ));
                                      },
                                      onRestriction: !cubit
                                              .checkRestrictionsFood(
                                                  productId: HomeCubit
                                                      .currentChild
                                                      .schoolModel
                                                      .foodMenuModelList[index]
                                                      .id)
                                          ? () {
                                              cubit.addToRestrictionsFood(
                                                  childId:
                                                      HomeCubit.currentChild.id,
                                                  productId: HomeCubit
                                                      .currentChild
                                                      .schoolModel
                                                      .foodMenuModelList[index]
                                                      .id);
                                            }
                                          : null,
                                      cal: HomeCubit.currentChild.schoolModel
                                          .foodMenuModelList[index].cal,
                                      imagePath: cubit.checkRestrictionsFood(
                                              productId: HomeCubit
                                                  .currentChild
                                                  .schoolModel
                                                  .foodMenuModelList[index]
                                                  .id)
                                          ? 'assets/image/no.png'
                                          : 'assets/image/lez.png',
                                      itemName: HomeCubit
                                          .currentChild
                                          .schoolModel
                                          .foodMenuModelList[index]
                                          .foodName,
                                      price: HomeCubit
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
