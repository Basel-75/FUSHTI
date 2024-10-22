import 'package:customer_app/widget/row/app_bar_row_button.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

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
      height: inHomeScreen ? 30.h : 30.h,
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
          Text(
            'المدرسة',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Color(0xff854811),
              ),
              Text(
                childSchollName,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
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
                            Text(
                              'أهلا',
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              ' $parentName',
                              style: TextStyle(
                                  fontSize: 19.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          'نظم وجبات ابنائك',
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
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
