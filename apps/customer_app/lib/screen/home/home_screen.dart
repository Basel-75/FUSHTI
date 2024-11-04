import 'dart:developer';

import 'package:customer_app/screen/home/cubit/home_cubit.dart';
import 'package:customer_app/screen/order_cart/order_cart_screen.dart';
import 'package:customer_app/screen/pay_screen/pay_screen.dart';
import 'package:customer_app/screen/product/product_screen.dart';
import 'package:customer_app/widget/avatar/followers_avatar.dart';
import 'package:customer_app/widget/container/show_dialog_pay_widget.dart';
import 'package:customer_app/widget/image/image_handler.dart';
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
        return BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is DoneAddState) {
              showSnackBar(context: context, msg: state.msg, isError: false);
            }
            if (state is LoadingState) {
              showLoadingDialog(context: context);
            }
            if (state is SussesState) {
              Navigator.pop(context);

              showSnackBar(context: context, msg: state.msg, isError: false);
            }
            if (state is ErrorState) {
              Navigator.pop(context);

              showSnackBar(context: context, msg: state.msg, isError: true);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leadingWidth: 20.w,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialogPayWidget(
                        context: context,
                        priceTotal: cubit.priceTotal,
                        onPressed: () {},
                      );

                      //          Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) {
                      //     return PayScreen(
                      //       paymentConfig: state.paymentConfig,
                      //     );
                      //   },
                      // )).then(
                      //   (paymentResponse) {
                      //     log("in pay return");
                      //     if (paymentResponse is PaymentResponse) {
                      //       cubit.checkOut(paymentResponse: paymentResponse);
                      //     }
                      //   },
                      // );
                    },
                    child: const Icon(
                      Icons.monetization_on,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${cubit.appModel.userModel?.funds.toString()} رس',
                    style: const TextStyle(color: Colors.white),
                    textDirection: TextDirection.rtl,
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
                child: Align(
                  alignment: Alignment.topRight,
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
                                  color: const Color(0xff546F66)),
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
                                            childImage: cubit
                                                .childModelList[index].imgPath,
                                            textColor: cubit
                                                        .childModelList[index]
                                                        .isSelected ==
                                                    true
                                                ? Colors.green
                                                : Colors.black,
                                            childName: cubit
                                                .childModelList[index].name,
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
                                  color: const Color(0xff546F66)),
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: List.generate(
                                        cubit.currentChild.schoolModel
                                            .foodMenuModelList.length,
                                        (index) {
                                          return HomeCard(
                                            isRestriction:
                                                cubit.checkRestrictionsFood(
                                                    productId: cubit
                                                        .currentChild
                                                        .schoolModel
                                                        .foodMenuModelList[
                                                            index]
                                                        .id),
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) {
                                                  return ProductScreen(
                                                    childModel:
                                                        cubit.currentChild,
                                                    foodMenuModel: cubit
                                                            .currentChild
                                                            .schoolModel
                                                            .foodMenuModelList[
                                                        index],
                                                  );
                                                },
                                              ));
                                            },
                                            onRestriction:
                                                !cubit.checkRestrictionsFood(
                                                        productId: cubit
                                                            .currentChild
                                                            .schoolModel
                                                            .foodMenuModelList[
                                                                index]
                                                            .id)
                                                    ? () {
                                                        cubit.addToRestrictionsFood(
                                                            childId: cubit
                                                                .currentChild
                                                                .id,
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
                                            imagePath: cubit
                                                    .checkRestrictionsFood(
                                                        productId: cubit
                                                            .currentChild
                                                            .schoolModel
                                                            .foodMenuModelList[
                                                                index]
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
                                            onAdd: () => cubit.quickAddToCart(
                                                childModel: cubit.currentChild,
                                                foodMenuModel: cubit
                                                    .currentChild
                                                    .schoolModel
                                                    .foodMenuModelList[index]),
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
                                  color: const Color(0xff546F66)),
                            ),
                            BlocBuilder<HomeCubit, HomeState>(
                              builder: (context, state) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(vertical: 1.h),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: cubit.boxList
                                          .map(
                                            (e) => HomeCard(
                                              //values
                                              isRestriction:
                                                  cubit.checkRestrictionsFood(
                                                      productId: e.id),
                                              productName: e.foodName,
                                              price: '${e.price}',
                                              cal: '${e.cal}',
                                              imagePath: '${e.imageUrl}',
                                              //functions
                                              onAdd: () => cubit.quickAddToCart(
                                                  childModel:
                                                      cubit.currentChild,
                                                  foodMenuModel: e),
                                              onRestriction: () =>
                                                  cubit.addToRestrictionsFood(
                                                      childId:
                                                          cubit.currentChild.id,
                                                      productId: e.id),
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductScreen(
                                                            foodMenuModel: e,
                                                            childModel: cubit
                                                                .currentChild),
                                                  )),
                                            ),
                                          )
                                          .toList()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Text(
                          'الوجبات',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff546F66)),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          // cubit.getListByType(
                          //     catagory: 'product',
                          //     schoolId: cubit.currentChild.schoolId);
                          return SizedBox(
                              height: 60.h,
                              width: 80.w,
                              child: cubit.productList.isNotEmpty
                                  ? GridView.builder(
                                      itemCount: cubit.productList.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 2.0.h,
                                        mainAxisSpacing: 1.0.h,
                                        //childAspectRatio: 0.12.h,
                                      ),
                                      itemBuilder: (context, index) => HomeCard(
                                        //value
                                        isRestriction:
                                            cubit.checkRestrictionsFood(
                                                productId: cubit
                                                    .productList[index].id),
                                        productName:
                                            cubit.productList[index].foodName,
                                        price:
                                            '${cubit.productList[index].price}',
                                        cal: '${cubit.productList[index].cal}',
                                        imagePath:
                                            '${cubit.productList[index].imageUrl}',
                                        //Function
                                        onAdd: () => cubit.quickAddToCart(
                                            childModel: cubit.currentChild,
                                            foodMenuModel:
                                                cubit.productList[index]),
                                        onRestriction: () =>
                                            cubit.addToRestrictionsFood(
                                                childId: cubit.currentChild.id,
                                                productId: cubit
                                                    .productList[index].id),
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductScreen(
                                                      foodMenuModel: cubit
                                                          .productList[index],
                                                      childModel:
                                                          cubit.currentChild),
                                            )),
                                      ),
                                    )
                                  : const Center(
                                      child: Text('لا توجد وجبات ):'),
                                    ));
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
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
  final bool isRestriction;
  const HomeCard({
    super.key,
    required this.productName,
    required this.price,
    required this.cal,
    this.onTap,
    this.onRestriction,
    this.onAdd,
    required this.imagePath,
    required this.isRestriction,
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
                  const Spacer(),
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
                            color: const Color(0x50000000)),
                      ),
                      const Icon(LineAwesome.fire_alt_solid,
                          color: Color(0xffEC8743))
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
                backgroundColor: const Color(0x88C8E5F5),
                child: !isRestriction
                    ? ImageHandler(imagePath: imagePath)
                    : ImageHandler(
                        imagePath: imagePath,
                        errorWidget: const Icon(Icons.no_food),
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
                    color: const Color(0xffC9E7E7),
                    borderRadius: BorderRadius.circular(6)),
                child: const Icon(
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
