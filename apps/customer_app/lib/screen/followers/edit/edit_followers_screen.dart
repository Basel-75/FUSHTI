import 'dart:developer';


import 'package:customer_app/screen/followers/edit/edit_followers_cubit/edit_followers_cubit.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/dropDownMenu/custom_multi_select.dart';
import 'package:customer_app/widget/dropDownMenu/custom_select.dart';
import 'package:customer_app/widget/image/image_handler.dart';

import 'package:customer_app/widget/textFormFeild/custom_text_form_felid.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class EditFollowersScreen extends StatelessWidget {
  const EditFollowersScreen({super.key, required this.childInfo});
  final ChildModel? childInfo;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditFollowersCubit(childModel:  childInfo!)..initVal(),
      child: Builder(builder: (context) {
        final cubit = context.read<EditFollowersCubit>();
        
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BlocListener<EditFollowersCubit, EditFollowersState>(
            listener: (context, state) {
              if (state is LoadingState) {
                showLoadingDialog(context: context);
              }

              if (state is SuccessEditState) {
                Navigator.pop(context);
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'تم تحديث معلومات التابع بنجاح',
                      textDirection: TextDirection.rtl,
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context,true);
                log("very Good Edit child");
              }

              if (state is UnLoadingState) {
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
            },
            child: Form(
              key: cubit.formKey,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  title: Text(
                    'تعديل التابع',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  centerTitle: true,
                  flexibleSpace: Container(
                    //height: 15.h,
                    decoration: const BoxDecoration(
                      color: Color(0xff6FBAE5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                    ),
                  ),
                  toolbarHeight: 11.h,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        width: 30.w,
                        height: 30.w,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 218, 220, 218),
                            shape: BoxShape.circle,
                            border: Border.all(width: 0.2, color: Colors.grey)),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ImageHandler(
                                  imagePath: childInfo!.imgPath,

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      CustomTextFormFelid(
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'يرجى تعبئة الحقل';
                            }
                            if (RegExp(r'[0-9]').hasMatch(val)) {
                              return 'الاسم لا يمكن ان يحتوي على ارقام';
                            }
                            return null;
                          },
                          controller: cubit.nameCon,
                          label: 'الاسم',
                          hintText: 'باسل العلوي',
                          textDirection: TextDirection.rtl,
                          isPassword: false),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomSelect(
                        initSchoolDrop: cubit.initSchoolDrop,
                        validator: (val) {
                          log("got to shcoll");
                          if (cubit.schoolCon.text.isEmpty) {
                            log("not on  shcoll");
                            return "يرجى اختيار المدرسة";
                          }
                          log("iam to shcoll");

                          return null;
                        },
                        label: 'المدرسة',
                        hintText: 'اختر المدرسة',
                        items: cubit.school,

                        onChanged: (p0) {
                          cubit.schoolCon.text = p0!.name;
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomTextFormFelid(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'يرجى تعبئة الحقل';
                          }
                          return null;
                        },
                        controller: cubit.classCon,
                        label: 'الفصل',
                        hintText: '2ب',
                        isPassword: false,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomMultiSelect(
                        initialItems: cubit.initAlergy,

                        label: 'الحساسية',
                        hintText: 'اختر الحساسية',
                        items: cubit.alergy,
                        onListChanged: (val) {
                          cubit.allgyList = val;
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),

                      SizedBox(
                        height: 4.h,
                      ),
                      CustomButton(
                        onPressed: () {
                          cubit.editChild();
                        },
                        title: 'تعديل التابع',
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
