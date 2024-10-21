import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/container/product_small_container.dart';
import 'package:customer_app/widget/container/restriction_card.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class RestrictionsScreen extends StatelessWidget {
  const RestrictionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'الوجبات المحظورة',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          actions: [
            Image.asset('assets/image/homeicon.png'),
            SizedBox(
              width: 2.h,
            )
          ],
          flexibleSpace: Container(
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
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 77.h,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
                child: const Column(
                  children: [
                    RestrictionCard(
                      productName: 'بوكس السعادة',
                      cal: '120',
                      price: '12',
                      imagePath: 'assets/image/boxImage.png',
                    ),
                    RestrictionCard(
                      productName: 'شيبس ليز',
                      cal: '120',
                      price: '12',
                      imagePath: 'assets/image/lez.png',
                    ),
                    RestrictionCard(
                      productName: 'سندوتش بيض',
                      cal: '120',
                      price: '12',
                      imagePath: 'assets/image/egg.png',
                    ),
                    RestrictionCard(
                      productName: 'بوكس السعادة',
                      cal: '120',
                      price: '12',
                      imagePath: 'assets/image/boxImage.png',
                    ),
                    RestrictionCard(
                      productName: 'بوكس السعادة',
                      cal: '120',
                      price: '12',
                      imagePath: 'assets/image/boxImage.png',
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            CustomButton(onPressed: () {}, title: 'تأكيد'),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
