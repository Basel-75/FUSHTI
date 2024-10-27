import 'dart:developer';

import 'package:employee_app/widget/appbar_emp_header.dart';
import 'package:employee_app/widget/button/custome_button.dart';
import 'package:employee_app/widget/dropDownList/custom_drop_down_list.dart';
import 'package:employee_app/widget/textFormField/custom_image.dart';
import 'package:employee_app/widget/textFormField/custom_text_area.dart';
import 'package:employee_app/widget/textFormField/custome_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

// addImg() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       imgfiel = File(image.path);

//       imgcontroller.text = image.name;
//     }
//   }

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(19.h),
            child: AppBar(
              flexibleSpace: EmployeeHeader(
                isTitle: true,
                title: 'اضافة منتج',
                textSize: 19.sp,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                CustomTextFormFelid(
                    //controller: ,
                    iconText: const Icon(Bootstrap.github),
                    keyboardType: TextInputType.text,
                    hasIcon: false,
                    paddingRightSide: 8.w,
                    paddingLeftSide: 8.w,
                    containerSize: 85.w,
                    hintText: 'بكس السعادة',
                    isPassword: false,
                    label: 'اسم المنتج',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('ارجوا منك أضافة اسم المنتج'),
                          backgroundColor: Colors.red,
                        ));
                        return "لابد وضع اسم المنتج";
                      } else if (RegExp(r'[0-9]').hasMatch(value)) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('الاسم لا يحتوي على أرقام'),
                          backgroundColor: Colors.red,
                        ));
                        return "بدون أرقام";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextFormFelid(
                        keyboardType: TextInputType.number,
                        iconText: const Icon(
                          Bootstrap.currency_dollar,
                          color: Colors.black38,
                        ),
                        hasIcon: true,
                        paddingRightSide: 8.w,
                        paddingLeftSide: 0.w,
                        containerSize: 40.w,
                        //controller:
                        hintText: '210',
                        isPassword: false,
                        label: 'السعر',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('ارجوا منك أضافة السعر'),
                              backgroundColor: Colors.red,
                            ));
                            return "يجب أضافة السعر";
                          }
                          return null;
                        }),
                    CustomTextFormFelid(
                        keyboardType: TextInputType.number,
                        iconText: const Icon(
                          Bootstrap.fire,
                          color: Colors.black38,
                        ),
                        hasIcon: true,
                        paddingRightSide: 0.w,
                        paddingLeftSide: 8.w,
                        containerSize: 40.w,
                        //controller:
                        hintText: '300',
                        isPassword: false,
                        label: 'السعرات',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('يجب كتابة السعرات'),
                              backgroundColor: Colors.red,
                            ));
                            return "يجب كتابة السعرات";
                          }
                          return null;
                        }),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDrop(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'اختر من القائمة';
                        }
                        return null;
                      },
                      onChanged: (p0) {
                        log('$p0');
                      },
                      //controller:
                      items: ["بوكسات", "منتجات"],
                      isPassword: false,
                      hintText: 'تيست تيست',
                      label: 'الحساسية',
                      paddingRightSide: 8.w,
                      paddingLeftSide: 0.w,
                      containerSize: 40.w,
                    ),
                    CustomDrop(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'اختر من القائمة';
                        }
                        return null;
                      },
                      onChanged: (p0) {},
                      //controller:
                      items: ["بوكسات", "منتجات"],
                      isPassword: false,
                      hintText: 'تيست',
                      label: 'النوع',
                      paddingRightSide: 0.w,
                      paddingLeftSide: 8.w,
                      containerSize: 40.w,
                    )
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomTextArea(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('ارجوا منك أضافة وصف المنتج'),
                        backgroundColor: Colors.red,
                      ));
                      return "يجب كتابة وصف المنتج";
                    }
                    return null;
                  },
                  //controller:
                  label: 'وصف المنتج',
                  hintText: 'أكتب وصفًا للمنتج...',
                  containerSize: 84.w,
                  padding: 4.h,
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomImage(
                    onTap: () {
                      print('clicked image');
                      //addImg();
                    },
                    //controller:
                    iconText: const Icon(Bootstrap.image),
                    hasIcon: true,
                    paddingRightSide: 8.w,
                    paddingLeftSide: 8.w,
                    containerSize: 85.w,
                    hintText: 'بكس السعادة',
                    label: 'صورة المنتج',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('ضع صورة المنتج'),
                          backgroundColor: Colors.red,
                        ));
                        return "يجب وضع صورة للمنتج";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 5.h,
                ),
                CustomButton(
                    onPressed: () {
                      {
                        if (formKey.currentState?.validate() ?? false) {
                          print("test");
                        } else {
                          print("test not");
                        }
                      }
                    },
                    title: 'اضافة المنتج'),
                SizedBox(
                  height: 3.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
