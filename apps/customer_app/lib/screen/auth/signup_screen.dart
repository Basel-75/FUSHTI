import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/button/custom_text_button.dart';
import 'package:customer_app/widget/row/brand_row.dart';
import 'package:customer_app/widget/textFormFeild/custom_text_form_felid.dart';
import 'package:flutter/material.dart';

import 'package:get_all_pkg/get_all_pkg.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                      'تسجيل',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff103C37)),
                    ),
                    const CustomTextFormFelid(
                      hintText: 'example@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      isPassword: false,
                      label: 'الايميل',
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const CustomTextFormFelid(
                      hintText: 'مثال : باسل العلوي',
                      isPassword: false,
                      label: 'الاسم',
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const CustomTextFormFelid(
                      hintText: '0512345678',
                      isPassword: false,
                      label: 'رقم الجوال',
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    CustomButton(
                      onPressed: () {},
                      title: 'تسجيل الدخول',
                    ),
                    CustomTextButton(
                      buttonTitle: 'تسجيل',
                      question: 'انشاء حساب جديد',
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    const BrandRow(),
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
