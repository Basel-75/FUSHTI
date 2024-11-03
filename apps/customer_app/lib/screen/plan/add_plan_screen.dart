import 'dart:developer';

import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/container/add_plan_card.dart';
import 'package:customer_app/widget/container/info_container_with_button.dart';
import 'package:customer_app/widget/datePicker/date_picker_button.dart';
import 'package:customer_app/widget/devider/custom_dot_line.dart';
import 'package:customer_app/widget/textFormFeild/custom_text_form_felid.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class AddPlanScreen extends StatelessWidget {
  const AddPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'اضافة خطة',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          actions: [
            Image.asset('assets/image/homeicon.png'),
            SizedBox(
              width: 2.h,
            )
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffFEFEFD), Color(0xffE0D1BB)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                )),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              const CustomTextFormFelid(
                label: 'اسم الخطة',
                hintText: 'خطة الصحة',
                isPassword: false,
              ),
              SizedBox(
                height: 4.h,
              ),
              InfoContainerWithButton(
                title: 'عدد الوجبات',
                amount: '6',
                onPressedInfo: () {},
                smallContainerColor: const Color(0xffe5dfcf),
              ),
              SizedBox(
                height: 35.h,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '     المنتجات',
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      AddPlanCard(
                        productName: 'بوكس السعادة',
                        cal: '150',
                        price: '12',
                        quantity: '1',
                        imagePath: 'assets/image/boxImage.png',
                        onAdd: () {},
                        onMinus: () {},
                        onDelete: () {},
                        withoutDelete: false,
                      ),
                      AddPlanCard(
                        productName: 'بوكس السعادة',
                        cal: '150',
                        price: '12',
                        quantity: '1',
                        imagePath: 'assets/image/boxImage.png',
                        onAdd: () {},
                        onMinus: () {},
                        onDelete: () {},
                        withoutDelete: false,
                      ),
                      AddPlanCard(
                        productName: 'بوكس السعادة',
                        cal: '150',
                        price: '12',
                        quantity: '1',
                        imagePath: 'assets/image/boxImage.png',
                        onAdd: () {},
                        onMinus: () {},
                        onDelete: () {},
                        withoutDelete: false,
                      ),
                    ],
                  ),
                ),
              ),
              const CustomDotLine(),
              SizedBox(
                height: 1.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  '    تاريخ الخطة',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DatePickerButton(
                    title: 'بداية الخطة',
                    onDateChange: (startDate) {
                      log('$startDate');
                    },
                  ),
                  DatePickerButton(
                    title: 'نهاية الخطة',
                    onDateChange: (endDate) {
                      log('$endDate');
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomButton(onPressed: () {}, title: 'اضافة الخطة'),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
