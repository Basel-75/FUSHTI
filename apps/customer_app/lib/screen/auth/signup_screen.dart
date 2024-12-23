import 'package:customer_app/screen/auth/cubit/auth_cubit.dart';
import 'package:customer_app/screen/auth/otp_screen.dart';
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
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AuthCubit>();
        return Form(
          key: cubit.formKey,
          child: BlocListener<AuthCubit, AuthStatee>(
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OTPScreen(
                        email: cubit.emailCon.text,
                        name: cubit.nameCon.text,
                        phone: cubit.phoneCon.text,
                      ),
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
                            'assets/image/mainLogo.png',
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            'تسجيل',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff103C37)),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Column(
                              children: [
                                CustomTextFormFelid(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('يرجى ادخال الايميل'),
                                        backgroundColor: Colors.red,
                                      ));

                                      return "";
                                    } else if (!RegExp(
                                            r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                        .hasMatch(value)) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('ايميل غير صالح'),
                                        backgroundColor: Colors.red,
                                      ));

                                      return "";
                                    }
                                    return null;
                                  },
                                  backgroundColor: const Color(0xffF6FAFD),
                                  hintText: 'example@gmail.com',
                                  keyboardType: TextInputType.emailAddress,
                                  isPassword: false,
                                  label: 'الايميل',
                                  controller: cubit.emailCon,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                CustomTextFormFelid(
                                    backgroundColor: const Color(0xffF6FAFD),
                                    controller: cubit.nameCon,
                                    hintText: 'فهد',
                                    isPassword: false,
                                    label: 'الاسم',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text('يرجى ادخال الاسم'),
                                          backgroundColor: Colors.red,
                                        ));
                                        return "";
                                      } else if (RegExp(r'[0-9]')
                                          .hasMatch(value)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              'الاسم لا يمكن ان يحتوي على ارقام'),
                                          backgroundColor: Colors.red,
                                        ));
                                        return "";
                                      }
                                      return null;
                                    }),
                                SizedBox(
                                  height: 2.h,
                                ),
                                CustomTextFormFelid(
                                    backgroundColor: const Color(0xffF6FAFD),
                                    controller: cubit.phoneCon,
                                    hintText: '0512345678',
                                    isPassword: false,
                                    label: 'رقم الجوال',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text('يرجى ادخال رقم الجوال'),
                                          backgroundColor: Colors.red,
                                        ));
                                        return "";
                                      } else if (!RegExp(r'^05[0-9]{8}$')
                                          .hasMatch(value)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              'رقم الهاتف يجب ان يبدأ ب 05'),
                                          backgroundColor: Colors.red,
                                        ));
                                        return "";
                                      }
                                      return null;
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          CustomButton(
                            onPressed: () {
                              cubit.singup();
                            },
                            title: 'تسجيل حساب',
                          ),
                          CustomTextButton(
                            buttonTitle: 'تسجيل دخول',
                            question: 'هل لديك حساب؟',
                            onPressed: () {
                              Navigator.pop(context);
                            },
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
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
