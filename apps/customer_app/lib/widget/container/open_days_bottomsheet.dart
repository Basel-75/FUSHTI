import 'package:customer_app/widget/button/custom_button.dart';
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
          height: 30.h,
          decoration: const BoxDecoration(boxShadow: []),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  const Text('الأيام المفتوحة'),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('حالة اليوم'),
                      AdvancedSwitch(
                          initialValue: initialValueRaido,
                          activeColor: Colors.green,
                          inactiveColor:
                              const Color.fromARGB(255, 204, 108, 108),
                          width: 14.w,
                          onChanged: onChangedSwitch),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  CustomTextFormFelid(
                    validator: validator,
                    horizontal: 0.w,
                    label: 'المصروف',
                    hintText: '25',
                    isPassword: false,
                    keyboardType: TextInputType.number,
                    controller: controller,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: CustomButton(
                      onPressed: onPressedButton,
                      title: 'اضافة التابع',
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
