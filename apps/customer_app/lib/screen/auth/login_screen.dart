import 'package:customer_app/screen/auth/cubit/auth_cubit.dart';
import 'package:customer_app/screen/auth/otp_screen.dart';
import 'package:customer_app/screen/auth/signup_screen.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/button/custom_text_button.dart';
import 'package:customer_app/widget/row/brand_row.dart';
import 'package:customer_app/widget/textFormFeild/custom_text_form_felid.dart';
import 'package:flutter/material.dart';

import 'package:get_all_pkg/get_all_pkg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OTPScreen(
                      email: cubit.emailCon.text,
                    ),
                  ));
            }
          },
          child: Form(
            key: cubit.formKey,
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
                            'assets/image/mainLogo2.png',
                          ),
                          Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff103C37)),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: CustomTextFormFelid(
                              controller: cubit.emailCon,
                              hintText: 'example@gmail.com',
                              keyboardType: TextInputType.emailAddress,
                              isPassword: false,
                              label: 'الايميل',
                              backgroundColor: const Color(0xffF6FAFD),
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
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          CustomButton(
                            onPressed: () {
                              cubit.singup();
                            },
                            title: 'تسجيل الدخول',
                          ),
                          CustomTextButton(
                            buttonTitle: 'تسجيل',
                            question: 'ليس لديك حساب',
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                )),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          const BrandRow(),
                          SizedBox(
                            height: 18.h,
                          ),
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
