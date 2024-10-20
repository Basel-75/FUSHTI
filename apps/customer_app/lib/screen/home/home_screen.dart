import 'dart:developer';

import 'package:customer_app/screen/home/cubit/home_cubit.dart';
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
                        const Text(
                          'التابعين',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
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
                        const Text(
                          'الأفضل مبيعا',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
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

class FollowersAvatar extends StatelessWidget {
  final String childName;
  final String childImage;
  final Function()? onTap;
  const FollowersAvatar({
    super.key,
    required this.onTap,
    required this.childName,
    required this.childImage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ChildAvatar(
        childName: childName,
        imagePath: childImage,
      ),
    );
  }
}

class ScreenHeader extends StatelessWidget {
  final String parentName, title, funds, childSchollName;
  final bool inHomeScreen;
  const ScreenHeader({
    super.key,
    required this.funds,
    required this.childSchollName,
    required this.parentName,
    required this.title,
    required this.inHomeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 28.h,
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFEFEFD), Color(0xffE0D1BB)],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 7.h,
          ),
          const Text(
            'المدرسة',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Color(0xff854811),
              ),
              Text(
                childSchollName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              AppBarRowButton(
                walletAmount: funds,
              ),
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            children: [
              inHomeScreen
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'أهلا',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              parentName,
                              style: const TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Text(
                          'نظم وجبات ابنائك',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : Text(
                      title,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
              const Spacer(),
              Image.asset('assets/image/homeicon.png')
            ],
          ),
        ],
      ),
    );
  }
}

class AppBarRowButton extends StatelessWidget {
  final String walletAmount;
  const AppBarRowButton({
    super.key,
    required this.walletAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            width: 43,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xffE0D2BC),
            ),
            child: const Icon(Iconsax.shopping_cart_outline),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            width: 43,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xffE0D2BC),
            ),
            child: Column(
              children: [
                const Icon(
                  Iconsax.wallet_2_outline,
                ),
                Text(walletAmount)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class HomeCard extends StatelessWidget {
  final String imagePath, itemName, rate;
  final double price;
  final int cal;

  const HomeCard({
    super.key,
    required this.imagePath,
    required this.itemName,
    required this.price,
    required this.cal,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      //height: 22.h,
      padding: EdgeInsets.symmetric(horizontal: 0.8.h, vertical: 0.8.h),
      margin: EdgeInsets.only(left: 3.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: kElevationToShadow[4]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            //!Send restriction logic here
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(bottom: 1.h),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.no_food_outlined, color: Colors.red),
            ),
          ),
          //!Change it later to image network
          Center(child: Image.asset(imagePath)),
          Text(
            itemName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Text(
                '$cal سعرة',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0x50000000)),
              ),
              const Spacer(),
              InkWell(
                //!Send add logic here
                onTap: () {},
                child: Container(
                  width: 8.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: kElevationToShadow[2],
                      color: const Color(0xffBA9773)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            children: [
              Text(
                '$price ريال',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Text(
                '$rate/5',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffFFE500)),
              ),
              const Icon(Icons.star_rate_rounded, color: Color(0xffFFE500))
            ],
          ),
        ],
      ),
    );
  }
}

class ChildAvatar extends StatelessWidget {
  final String imagePath, childName;
  const ChildAvatar({
    super.key,
    required this.imagePath,
    required this.childName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        Text(
          childName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
