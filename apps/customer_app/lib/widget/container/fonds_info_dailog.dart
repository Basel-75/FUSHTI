import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/textFormFeild/custom_text_form_felid.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class fondsInfoDailog extends StatelessWidget {
  const fondsInfoDailog(
      {super.key,
      this.controller,
      required this.cancelOnPressed,
      required this.okOnPressed,
      this.validator,
      this.formKey});
  final TextEditingController? controller;
  final Function() cancelOnPressed, okOnPressed;

  final String? Function(String?)? validator;
  final GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: formKey,
          child: Column(
            children: [
               Text(
                'اضافة رصيد',
                style: TextStyle(color: Colors.white,fontSize: 16.sp),
              ),
              CustomTextFormFelid(
                validator: validator,
                controller: controller,
                label: 'المبلغ',
                hintText: '50',
                isPassword: false,
                keyboardType: TextInputType.number,
                // controller: amount,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    onPressed: cancelOnPressed,
                    title: 'الغاء',
                    fixedSize: Size(30.w, 5.h),
                    backgroundColor: Colors.red,
                  ),
                  CustomButton(
                    onPressed: okOnPressed,
                    title: 'تأكيد',
                    fixedSize: Size(30.w, 5.h),
                    backgroundColor: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
