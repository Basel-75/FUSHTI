import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xff854811),
                        ),
                        const Text(
                          'الرياض, النموذجية السابعة',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Container(
                          width: 43,
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xffE0D2BC),
                          ),
                          child: const Icon(Iconsax.shopping_cart_outline),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 43,
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xffE0D2BC),
                          ),
                          child: const Column(
                            children: [
                              Icon(
                                Iconsax.wallet_2_outline,
                              ),
                              Text('200')
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'أهلا',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  ' أنس',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              'نظم وجبات ابنائك',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Image.asset('assets/image/homeicon.png')
                      ],
                    ),
                  ],
                ),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ChildAvatar(
                          childName: 'أنس',
                          imagePath: 'assets/image/kid1.png',
                        ),
                        ChildAvatar(
                          childName: 'يارا',
                          imagePath: 'assets/image/kid2.png',
                        ),
                        ChildAvatar(
                          childName: 'أنس',
                          imagePath: 'assets/image/kid1.png',
                        ),
                        ChildAvatar(
                          childName: 'يارا',
                          imagePath: 'assets/image/kid2.png',
                        ),
                        ChildAvatar(
                          childName: 'أنس',
                          imagePath: 'assets/image/kid1.png',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text(
                      'الأفضل مبيعا',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            cal: 30,
                            imagePath: 'assets/image/lez.png',
                            itemName: 'ليز',
                            onAdd: () {},
                            onRestrict: () {},
                            price: 2,
                            rate: '4.8',
                          ),
                          HomeCard(
                            cal: 30,
                            imagePath: 'assets/image/lez.png',
                            itemName: 'ليز',
                            onAdd: () {},
                            onRestrict: () {},
                            price: 2,
                            rate: '4.8',
                          ),
                          HomeCard(
                            cal: 30,
                            imagePath: 'assets/image/lez.png',
                            itemName: 'ليز',
                            onAdd: () {},
                            onRestrict: () {},
                            price: 2,
                            rate: '4.8',
                          ),
                          HomeCard(
                            cal: 30,
                            imagePath: 'assets/image/lez.png',
                            itemName: 'ليز',
                            onAdd: () {},
                            onRestrict: () {},
                            price: 2,
                            rate: '4.8',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text(
                      'أقسامنا',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                                  color: Color(0xffe7c7c5)),
                              child: Image.asset('assets/image/breakfast.png'),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 2.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xffe7c7c5)),
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
                                  color: Color(0xffd7bf9c)),
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
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            cal: 30,
                            imagePath: 'assets/image/lez.png',
                            itemName: 'بوكس السعادة',
                            onAdd: () {},
                            onRestrict: () {},
                            price: 2,
                            rate: '4.8',
                          ),
                          HomeCard(
                            cal: 30,
                            imagePath: 'assets/image/lez.png',
                            itemName: 'بوكس التغذية',
                            onAdd: () {},
                            onRestrict: () {},
                            price: 2,
                            rate: '4.8',
                          ),
                          HomeCard(
                            cal: 30,
                            imagePath: 'assets/image/lez.png',
                            itemName: 'بوكس المفرحات',
                            onAdd: () {},
                            onRestrict: () {},
                            price: 2,
                            rate: '4.8',
                          ),
                          HomeCard(
                            cal: 30,
                            imagePath: 'assets/image/lez.png',
                            itemName: 'ليز',
                            onAdd: () {},
                            onRestrict: () {},
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HomeCard(
                      cal: 30,
                      imagePath: 'assets/image/lez.png',
                      itemName: 'ليز',
                      onAdd: () {},
                      onRestrict: () {},
                      price: 2,
                      rate: '4.8',
                    ),
                    HomeCard(
                      cal: 30,
                      imagePath: 'assets/image/lez.png',
                      itemName: 'ليز',
                      onAdd: () {},
                      onRestrict: () {},
                      price: 2,
                      rate: '4.8',
                    ),
                    HomeCard(
                      cal: 30,
                      imagePath: 'assets/image/lez.png',
                      itemName: 'ليز',
                      onAdd: () {},
                      onRestrict: () {},
                      price: 2,
                      rate: '4.8',
                    ),
                    HomeCard(
                      cal: 30,
                      imagePath: 'assets/image/lez.png',
                      itemName: 'ليز',
                      onAdd: () {},
                      onRestrict: () {},
                      price: 2,
                      rate: '4.8',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h,),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String imagePath, itemName, rate;
  final double price;
  final int cal;
  final void Function() onRestrict, onAdd;
  const HomeCard({
    super.key,
    required this.imagePath,
    required this.itemName,
    required this.price,
    required this.cal,
    required this.rate,
    required this.onRestrict,
    required this.onAdd,
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
            onTap: onRestrict,
            child: Container(
              margin: EdgeInsets.only(bottom: 1.h),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.no_food_outlined, color: Colors.red),
            ),
          ),
          //!Change it later to image network
          Center(child: Image.asset(imagePath)),
          Text(
            itemName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Text(
                '$cal سعرة',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0x50000000)),
              ),
              Spacer(),
              InkWell(
                onTap: onAdd,
                child: Container(
                  width: 8.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: kElevationToShadow[2],
                      color: Color(0xffBA9773)),
                  child: Icon(
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
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Text(
                '$rate/5',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffFFE500)),
              ),
              Icon(Icons.star_rate_rounded, color: Color(0xffFFE500))
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
