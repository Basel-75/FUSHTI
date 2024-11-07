import 'package:customer_app/screen/followers/add/add_followers_cubit/add_followers_cubit.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/dropDownMenu/custom_multi_select.dart';
import 'package:customer_app/widget/dropDownMenu/custom_select.dart';

import 'package:customer_app/widget/textFormFeild/custom_text_form_felid.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class AddFollowersScreen extends StatelessWidget {
  const AddFollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFollowersCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AddFollowersCubit>();
        cubit.initVal();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BlocListener<AddFollowersCubit, AddFollowersState>(
            listener: (context, state) {
              if (state is LoadingState) {
                showLoadingDialog(context: context);
              }

              if (state is DoneAddState) {
                Navigator.pop(context);

                Navigator.pop(context, true);
              }

              if (state is NoLoadingState) {
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
                    'اضافة تابع',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  centerTitle: true,
                  flexibleSpace: Container(
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
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 7.h,
                        ),
                        CustomTextFormFelid(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'اضف اسم';
                              }
                              if (RegExp(r'[0-9]').hasMatch(val)) {
                                return 'الاسم يحتوي على ارقام';
                              }
                              return null;
                            },
                            backgroundColor: const Color(0xffF6FAFD),
                            controller: cubit.nameCon,
                            label: 'الاسم',
                            hintText: 'باسل العلوي',
                            isPassword: false),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomSelect(
                          validator: (val) {
                            if (cubit.schoolCon.text.isEmpty) {
                              return "اختر مدرسة";
                            }

                            return null;
                          },
                          backgroundColor: const Color(0xffF6FAFD),
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
                              return 'اضف صف';
                            }
                            return null;
                          },
                          backgroundColor: const Color(0xffF6FAFD),
                          controller: cubit.classCon,
                          label: 'الفصل',
                          hintText: '2ب',
                          isPassword: false,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomMultiSelect(
                          backgroundColor: const Color(0xffF6FAFD),
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
                              return 'اضف مصروف ';
                            }
                            if (double.tryParse(val) == null) {
                              return 'ادخل رقم صحيح';
                            }
                            return null;
                          },
                          backgroundColor: const Color(0xffF6FAFD),
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
                            cubit.addChild();
                          },
                          title: 'اضافة التابع',
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
