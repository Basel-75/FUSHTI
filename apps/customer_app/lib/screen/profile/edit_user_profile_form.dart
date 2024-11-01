import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/textFormFeild/custom_text_form_felid.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class EditUserProfileForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController phoneNumController;
  final VoidCallback onSubmit;

  const EditUserProfileForm({
    super.key,
    required this.usernameController,
    required this.phoneNumController,
    required this.onSubmit,
  });

  void _validateAndSubmit(BuildContext context) {
    String? usernameError;
    String? phoneError;

    // Validate username
    if (usernameController.text.isEmpty) {
      usernameError = 'الرجاء إدخال اسم المستخدم';
    } else {
      final usernameRegExp = RegExp(r'^[a-zA-Z0-9_\-\u0600-\u06FF\s]+$');

      if (!usernameRegExp.hasMatch(usernameController.text)) {
        usernameError = 'اسم المستخدم يحتوي على أحرف غير صالحة';
      }
    }

    // Validate phone number
    if (phoneNumController.text.isEmpty) {
      phoneError = 'الرجاء إدخال رقم الجوال';
    } else {
      final phoneRegExp = RegExp(r'^[0-9]{10}$');
      if (!phoneRegExp.hasMatch(phoneNumController.text)) {
        phoneError = 'الرجاء إدخال رقم جوال صحيح';
      }
    }

    // check for error
    if (usernameError != null || phoneError != null) {
      final errorMessage = '${usernameError ?? ''}\n${phoneError ?? ''}';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage.trim(),
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      onSubmit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'تحديث الملف الشخصي',
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
        SizedBox(height: 1.h),
        CustomTextFormFelid(
          label: 'اسم المستخدم',
          hintText: 'باسل العلوي',
          isPassword: false,
          controller: usernameController,
        ),
        SizedBox(height: 1.h),
        CustomTextFormFelid(
          label: 'رقم الجوال',
          hintText: '0512345678',
          isPassword: false,
          keyboardType: TextInputType.phone,
          controller: phoneNumController,
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomButton(
              onPressed: () => Navigator.pop(context),
              title: 'الغاء',
              fixedSize: Size(30.w, 5.h),
              backgroundColor: Colors.red,
            ),
            CustomButton(
              onPressed: () => _validateAndSubmit(context),
              title: 'تأكيد',
              fixedSize: Size(30.w, 5.h),
              backgroundColor: Colors.green,
            ),
          ],
        ),
      ],
    );
  }
}
