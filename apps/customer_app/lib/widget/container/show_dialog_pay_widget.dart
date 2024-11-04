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
        child: Container(
          width: 25.w,
          height: 40.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: kElevationToShadow[8]),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomTextFormFelid(
                    controller: priceTotal,
                    label: "السعر",
                    hintText: "60",
                    isPassword: false),
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomButton(
                // backgroundColor: Color(0xffC8E5F5),
                onPressed: onPressed,
                title: "الدفع",
                fixedSize: Size(30.w, 5.h),
              )
            ],
          ),
        ),
      );
    },
  );
}
