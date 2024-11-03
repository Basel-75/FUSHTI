import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/devider/custom_dot_line.dart';
import 'package:customer_app/widget/textFormFeild/custom_text_form_felid.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class OpenDaysBottomSheet extends StatelessWidget {
  const OpenDaysBottomSheet(
      {super.key,
      this.onChangedSwitch,
      this.validator,
      this.controller,
      required this.onPressedButton,
      required this.initialValueRaido,
      this.formKey});
  final Function(dynamic)? onChangedSwitch;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function() onPressedButton;
  final bool initialValueRaido;
  final GlobalKey<FormState>? formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: 33.h,
          decoration:  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                   Text('الأيام المفتوحة',style: TextStyle(color: Color(0xff546F66),fontSize: 16.sp),),
                
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('تفعيل',style: TextStyle(color: Color(0xff546F66),fontSize: 16.sp),),
                      AdvancedSwitch(
                          initialValue: initialValueRaido,
                          activeColor: Color(0xff6FBAE5),
                          inactiveColor:
                              const Color(0x56ECB0B0),
                          width: 12.w,
                          height: 3.h,
                          onChanged: onChangedSwitch),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextFormFelid(
                    validator: validator,
                    horizontal: 0.w,
                    label: 'الحد اليومي',
                    hintText: '25',
                    isPassword: false,
                    keyboardType: TextInputType.number,
                    controller: controller,
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: CustomButton(
                      onPressed: onPressedButton,
                      title: 'تأكيد',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
