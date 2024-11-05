import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/textFormFeild/custom_text_form_felid.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

showDialogPayWidget(
    {required BuildContext context,
    required TextEditingController priceTotal,
    required void Function() onPressed}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: GlassContainer(
          height: 30.h,
          width: 80.w,
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.40),
              Colors.white.withOpacity(0.10)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderGradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.60),
              Colors.white.withOpacity(0.10),
              Colors.lightBlueAccent.withOpacity(0.05),
              Colors.lightBlueAccent.withOpacity(0.6)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.39, 0.40, 1.0],
          ),
          blur: 15.0,
          borderWidth: 1.5,
          elevation: 3.0,
          isFrostedGlass: true,
          shadowColor: Colors.black.withOpacity(0.20),
          alignment: Alignment.center,
          frostedOpacity: 0.12,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Center(
            child: Column(
              children: [
                Text(
                  'شحن المحفظة',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(height: 1.h),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomTextFormFelid(
                      controller: priceTotal,
                      label: "المبلغ",
                      hintText: "60",
                      isPassword: false),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      backgroundColor: Colors.green,
                      onPressed: onPressed,
                      title: "تأكيد",
                      fixedSize: Size(30.w, 5.h),
                    ),
                    CustomButton(
                      onPressed: () => Navigator.pop(context),
                      title: 'الغاء',
                      fixedSize: Size(30.w, 5.h),
                      backgroundColor: Colors.red,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
