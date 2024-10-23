import 'dart:developer';

import 'package:customer_app/screen/auth/cubit/auth_cubit.dart';
import 'package:customer_app/screen/home/home_screen.dart';
import 'package:customer_app/widget/button/custom_button.dart';

import 'package:customer_app/widget/button/custom_text_button.dart';

import 'package:flutter/material.dart';

import 'package:get_all_pkg/get_all_pkg.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key, required this.email, this.name, this.phone});

  final String email;
  final String? name;
  final String? phone;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AuthCubit>();
        return BlocListener<AuthCubit, AuthStatee>(
          listener: (context, state) {
            if (state is NoLoadingState) {
              Navigator.pop(context);
            }

            if (state is ErrorState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.msg,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.red,
              ));
            }

            if (state is LoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }

            if (state is SuccessState) {
              Navigator.pop(context);

              log("very good otp");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
            }
          },
          child: Scaffold(
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
                            onChanged: (value) {
                              cubit.otp = value;
                              log("the otp is ${cubit.otp}");
                            },
                            defaultPinTheme: PinTheme(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                    color: const Color(0xffF3F2D7),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: const Color(0xff34673F)))),
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
                            onPressed: () {
                              cubit.otpCheck(email: email, name: name , phone: phone);
                              
                            },
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
          ),
        );
      }),
    );
  }
}
