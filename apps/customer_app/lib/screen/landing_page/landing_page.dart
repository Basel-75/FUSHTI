import 'package:customer_app/screen/auth/login_screen.dart';
import 'package:customer_app/widget/BoardingSlider/content_slider.dart';
import 'package:customer_app/widget/BoardingSlider/image_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: 'سجل الأن',
        onFinish: () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (builder) {
            return const LoginScreen();
          }));
        },
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: Color(0xff6FBAE5),
          // shape: CircleBorder(),
        ),
        background: [
          ImageSlider(
            image: 'assets/image/landing_page1.png',
            sizeBoxHeight: 8.h,
            sizeBoxWidth: 20.w,
          ),
          ImageSlider(
            image: 'assets/image/landing_page2.png',
            sizeBoxHeight: 15.h,
            sizeBoxWidth: 4.w,
          ),
          ImageSlider(
            image: 'assets/image/landing_page3.png',
            sizeBoxHeight: 11.h,
            sizeBoxWidth: 17.w,
          ),
        ],
        totalPage: 3,
        speed: 1.0,
        pageBodies: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: const ContentSlider(
              titleText: 'جهز وجبات ابنائك من بيتك',
              subTitleText:
                  'تقدر تسوي خطة غذائية وأيام مفتوحة وتتبع وجبات أطفالك كلها بضغطه زر',
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: const ContentSlider(
              titleText: 'خذ طلبك من المقصف بضغطة زر',
              subTitleText:
                  'امكانية عرض الباركود للكافتيريا واختيار الوجبات وانت مطمئن',
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: const ContentSlider(
              titleText: 'طفلك يأكل افضل وجباته',
              subTitleText:
                  'يختار افضل وجباته ويتجنب الاطعمة المسببة للحساسية ',
            ),
          ),
        ],
      ),
    );
  }
}
