


import 'package:customer_app/widget/button/custom_button.dart';

import 'package:customer_app/widget/button/custom_text_button.dart';

import 'package:flutter/material.dart';

import 'package:get_all_pkg/get_all_pkg.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  fin() {
    methhh();

    pin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/image/auth_header1.png',
                        ),
                        const Spacer(),
                        Image.asset(
                          'assets/image/auth_header2.png',
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/image/logo.png',
                    ),
                    const Text(
                      'رمز التحقق',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff103C37)),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Pinput(
                      length: 6,
                      onSubmitted: (value) {},
                      defaultPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                              color: const Color(0xffF3F2D7),
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: const Color(0xff34673F)))),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomTextButton(
                        buttonTitle: 'اعادة الارسال',
                        question: 'لم يصلني رمز التحقق',
                        onPressed: () {}),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomButton(
                      onPressed: () {},
                      title: 'تحقق',
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Image.asset(
                          'assets/image/auth_bottom1.png',
                        ),
                        const Spacer(),
                        Image.asset(
                          'assets/image/auth_bottom2.png',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
