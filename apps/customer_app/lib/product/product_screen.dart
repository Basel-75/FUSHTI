import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffFFFFFF), Color(0xffE0D1BB)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 100.w,
                height: 44.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffFFFFFF), Color(0xffE0D1BB)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
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
                          BoxItemContainer(
                            itemName: 'ليز',
                            imagePath: 'assets/image/lez.png',
                          ),
                          BoxItemContainer(
                            itemName: 'ليز',
                            imagePath: 'assets/image/lez.png',
                          ),
                          BoxItemContainer(
                            itemName: 'ليز',
                            imagePath: 'assets/image/lez.png',
                          ),
                          BoxItemContainer(
                            itemName: 'ليز',
                            imagePath: 'assets/image/lez.png',
                          ),
                          BoxItemContainer(
                            itemName: 'ليز',
                            imagePath: 'assets/image/lez.png',
                          ),
                          BoxItemContainer(
                            itemName: 'ليز',
                            imagePath: 'assets/image/lez.png',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)
                  ),
                  boxShadow: kElevationToShadow[4]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BoxItemContainer extends StatelessWidget {
  final String itemName, imagePath;
  const BoxItemContainer({
    super.key,
    required this.itemName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 23.w,
      height: 13.h,
      padding: EdgeInsets.symmetric(horizontal: 0.2.w),
      margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
      constraints: BoxConstraints(minHeight: 13.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xffFFFFFF), Color(0xffE0D1BB)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: kElevationToShadow[4],
      ),
      child: Column(
        children: [
          const Spacer(),
          Image.asset(
            imagePath,
          ),
          Text(
            itemName,
            style: TextStyle(fontSize: 16.sp, overflow: TextOverflow.ellipsis),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
