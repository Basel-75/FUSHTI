import 'dart:developer';

import 'package:customer_app/component/drop_down_item.dart';
import 'package:customer_app/main.dart';
import 'package:customer_app/screen/auth/cubit/auth_cubit.dart';

import 'package:customer_app/screen/followers/cubit/edit_followers_cubit/edit_followers_cubit.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/dropDownMenu/custom_multi_select.dart';
import 'package:customer_app/widget/dropDownMenu/custom_select.dart';
import 'package:customer_app/widget/imagePicker/select_image_widget.dart';
import 'package:customer_app/widget/textFormFeild/custom_text_form_felid.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class EditFollowersScreen extends StatelessWidget {
  const EditFollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditFollowersCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<EditFollowersCubit>();
        cubit.initVal();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BlocListener<EditFollowersCubit, EditFollowersState>(
            listener: (context, state) {
              if (state is LodingState) {
                showLoadingDialog(context: context);
              }

              if (state is DoenAddState) {
                Navigator.pop(context);

                log("very Good add child");
              }

              if (state is NoLodingState) {
                Navigator.pop(context);
              }

              if (state is ErorrState) {
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
                  title: const Text(
                    'تعديل التابع',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 6.h,
                        ),
                        SelectImageWidget(
                          onDelete: () {
                            log('message');
                          },
                          onTapInCamera: () {},
                        ),
                        CustomTextFormFelid(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Name cannot be empty';
                              }
                              if (RegExp(r'[0-9]').hasMatch(val)) {
                                return 'Name cannot contain numbers';
                              }
                              return null;
                            },
                            controller: cubit.nameCon,
                            label: 'الاسم',
                            hintText: 'باسل العلوي',
                            isPassword: false),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomSelect(
                          validator: (val) {
                            log("got to shcoll");
                            if (cubit.schoolCon.text.isEmpty) {
                              log("not on  shcoll");
                              return "pls give school";
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
                              return 'Class name cannot be empty';
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
                        CustomTextFormFelid(
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Amount cannot be empty';
                            }
                            if (double.tryParse(val) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                          label: 'المصروف',
                          hintText: '25',
                          isPassword: false,
                          keyboardType: TextInputType.number,
                          controller: cubit.fundsCon,
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
                      ],
                    ),
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
