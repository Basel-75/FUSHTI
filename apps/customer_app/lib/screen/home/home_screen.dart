import 'dart:async';
import 'dart:developer';

import 'package:customer_app/screen/home/cubit/home_cubit.dart';
import 'package:customer_app/screen/order_cart/order_cart_screen.dart';

import 'package:customer_app/screen/product/product_screen.dart';
import 'package:customer_app/widget/avatar/followers_avatar.dart';
import 'package:customer_app/widget/container/home_card.dart';
import 'package:customer_app/widget/container/show_dialog_pay_widget.dart';
import 'package:customer_app/widget/image/image_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (_currentPage < 3 - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(seconds: 2),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<HomeCubit>();
        cubit.initHome();
        cubit.getBestProduct();
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
                                              cubit.changeChild(
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
                                return Container(
                                  height: 22.h,
                                  //padding: EdgeInsets.symmetric(vertical: 2.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                    //boxShadow: kElevationToShadow[2]
                                  ),
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount: cubit.bestProductList.length,
                                    itemBuilder: (context, index) {
                                      final product =
                                          cubit.bestProductList[index];
                                      return Center(
                                        child: HomeCard(
                                          // Values
                                          withoutButton: true,
                                          productName: product.foodName,
                                          price: product.price.toString(),
                                          cal: product.cal.toString(),
                                          imagePath: '${product.imageUrl}',
                                          isRestriction: false,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
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
                                    children: cubit.boxList.map(
                                      (e) {
                                        final isRestr =
                                            cubit.checkRestrictionsFood(
                                                productId: e.id);

                                        return HomeCard(
                                          // Values
                                          withoutButton: false,
                                          isRestriction: isRestr,
                                          productName: e.foodName,
                                          price: '${e.price}',
                                          cal: '${e.cal}',
                                          imagePath: '${e.imageUrl}',
                                          // Functions
                                          onAdd: isRestr
                                              ? () => SchedulerBinding.instance
                                                      .addPostFrameCallback(
                                                          (_) {
                                                    showSnackBar(
                                                      context: context,
                                                      msg:
                                                          'لا يمكن اضافة منتج محظور الى السلة',
                                                      isError: true,
                                                    );
                                                  })
                                              : () => cubit.quickAddToCart(
                                                    childModel:
                                                        cubit.currentChild,
                                                    foodMenuModel: e,
                                                  ),
                                          onRestriction: () =>
                                              cubit.addToRestrictionsFood(
                                            childId: cubit.currentChild.id,
                                            productId: e.id,
                                          ),
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductScreen(
                                                foodMenuModel: e,
                                                childModel: cubit.currentChild,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
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
                                      ),
                                      itemBuilder: (context, index) {
                                        final product =
                                            cubit.productList[index];
                                        final isRestricted =
                                            cubit.checkRestrictionsFood(
                                                productId: product.id);

                                        return HomeCard(
                                          // Value
                                          withoutButton: false,
                                          isRestriction: isRestricted,
                                          productName: product.foodName,
                                          price: '${product.price}',
                                          cal: '${product.cal}',
                                          imagePath: '${product.imageUrl}',
                                          // Function
                                          onAdd: isRestricted
                                              ? () => SchedulerBinding.instance
                                                      .addPostFrameCallback(
                                                          (_) {
                                                    showSnackBar(
                                                        context: context,
                                                        msg:
                                                            'لا يمكن اضافة منتج محظور الى السلة',
                                                        isError: true);
                                                  })
                                              : () => cubit.quickAddToCart(
                                                    childModel:
                                                        cubit.currentChild,
                                                    foodMenuModel: product,
                                                  ),
                                          onRestriction: () =>
                                              cubit.addToRestrictionsFood(
                                            childId: cubit.currentChild.id,
                                            productId: product.id,
                                          ),
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductScreen(
                                                foodMenuModel: product,
                                                childModel: cubit.currentChild,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
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
