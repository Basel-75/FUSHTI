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
                            OrderCartScreen(childModel: cubit.currentChild),
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
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff546F66)),
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
                                    bool isClicked = true;
                                    return Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: FollowersAvatar(
                                        onTap: () {
                                          isClicked = !isClicked;
                                          log(isClicked.toString());
                                          log("chnageChild start");
                                          cubit.chnageChild(
                                              cubit.childModelList[index]);
                                        },
                                        childImage: 'assets/image/kid1.png',
                                        textColor: isClicked == false
                                            ? Colors.blue
                                            : Colors.black,
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
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff546F66)),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return SizedBox(
                              height: 22.h,
                              child: SingleChildScrollView(
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
                                                childModel: cubit.currentChild,
                                                foodMenuModel: cubit
                                                    .currentChild
                                                    .schoolModel
                                                    .foodMenuModelList[index],
                                              );
                                            },
                                          ));
                                        },
                                        onRestriction: !cubit
                                                .checkRestrictionsFood(
                                                    productId: cubit
                                                        .currentChild
                                                        .schoolModel
                                                        .foodMenuModelList[
                                                            index]
                                                        .id)
                                            ? () {
                                                cubit.addToRestrictionsFood(
                                                    childId:
                                                        cubit.currentChild.id,
                                                    productId: cubit
                                                        .currentChild
                                                        .schoolModel
                                                        .foodMenuModelList[
                                                            index]
                                                        .id);
                                              }
                                            : null,
                                        cal: cubit.currentChild.schoolModel
                                            .foodMenuModelList[index].cal
                                            .toString(),
                                        imagePath: cubit.checkRestrictionsFood(
                                                productId: cubit
                                                    .currentChild
                                                    .schoolModel
                                                    .foodMenuModelList[index]
                                                    .id)
                                            ? 'assets/image/no.png'
                                            : cubit
                                                .currentChild
                                                .schoolModel
                                                .foodMenuModelList[index]
                                                .imageUrl
                                                .toString()
                                                .trim(),
                                        productName: cubit
                                            .currentChild
                                            .schoolModel
                                            .foodMenuModelList[index]
                                            .foodName,
                                        price:
                                            '${cubit.currentChild.schoolModel.foodMenuModelList[index].price as double}',
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        // SizedBox(
                        //   height: 2.h,
                        // ),
                        Text(
                          'البوكسات',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff546F66)),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: cubit
                                  .getListByType(catagory: 'box')
                                  .map(
                                    (e) => HomeCard(
                                        productName: e.foodName,
                                        price: '${e.price}',
                                        cal: '${e.cal}',
                                        imagePath: '${e.imageUrl}'),
                                  )
                                  .toList()),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(right: 4.w),
                    child: Text(
                      'الوجبات',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff546F66)),
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  SizedBox(
                    height: 60.h,
                    width: 80.w,
                    child: cubit.getListByType(catagory: 'product').isNotEmpty
                        ? GridView.builder(
                            itemCount:
                                cubit.getListByType(catagory: 'product').length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 2.0.h,
                              mainAxisSpacing: 1.0.h,
                              //childAspectRatio: 0.12.h,
                            ),
                            itemBuilder: (context, index) => HomeCard(
                                productName: cubit
                                    .getListByType(catagory: 'product')[index]
                                    .foodName,
                                price:
                                    '${cubit.getListByType(catagory: 'product')[index].price}',
                                cal:
                                    '${cubit.getListByType(catagory: 'product')[index].cal}',
                                imagePath:
                                    '${cubit.getListByType(catagory: 'product')[index].imageUrl}'),
                          )
                        : Center(
                            child: Text('لا توجد وجبات ):'),
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

class HomeCard extends StatelessWidget {
  final String productName, price, cal, imagePath;
  final Function()? onTap, onRestriction, onAdd;
  const HomeCard({
    super.key,
    required this.productName,
    required this.price,
    required this.cal,
    this.onTap,
    this.onRestriction,
    this.onAdd,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.w,
      width: 35.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              width: 35.w,
              height: 35.w,
              margin: EdgeInsets.symmetric(horizontal: 1.w),
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: kElevationToShadow[8]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Text(
                    productName,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 1.w,
                  ),
                  Text(
                    '$price رس',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Text(
                        cal,
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0x50000000)),
                      ),
                      Icon(LineAwesome.fire_alt_solid, color: Color(0xffEC8743))
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              left: 12.w,
              bottom: 28.w,
              child: CircleAvatar(
                backgroundColor: Color(0x88C8E5F5),
                child: Image.network(
                  fit: BoxFit.contain,
                  imagePath,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.fastfood_rounded,
                    color: Colors.orange,
                  ),
                  loadingBuilder: (context, child, loadingProgress) =>
                      CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )),
          Positioned(
              left: 27.w,
              bottom: 32.w,
              child: InkWell(
                onTap: onRestriction,
                child: const Icon(Icons.no_food_outlined, color: Colors.red),
              )),
          Positioned(
            left: 3.w,
            bottom: 8.w,
            child: InkWell(
              onTap: onAdd,
              child: Container(
                width: 8.w,
                height: 7.w,
                decoration: BoxDecoration(
                    color: Color(0xffC9E7E7),
                    borderRadius: BorderRadius.circular(6)),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
