import 'dart:developer';

import 'package:employee_app/component/drop_down_item.dart';
import 'package:employee_app/screen/product/add_product/cubit/add_cubit.dart';
import 'package:employee_app/widget/appbar_emp_header.dart';
import 'package:employee_app/widget/button/custome_button.dart';
import 'package:employee_app/widget/dropDownList/custom_drop_down_list.dart';
import 'package:employee_app/widget/dropDownList/custom_multi_select.dart';
import 'package:employee_app/widget/dropDownList/custom_select.dart';
import 'package:employee_app/widget/textFormField/custom_image.dart';
import 'package:employee_app/widget/textFormField/custom_text_area.dart';
import 'package:employee_app/widget/textFormField/custome_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => AddCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AddCubit>();
        return BlocListener<AddCubit, EditState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showLoadingDialog(context: context);
            }
            if (state is ErrorState) {
              Navigator.pop(context);
              showSnackBar(context: context, msg: state.msg, isError: true);
            }
            if (state is SussesState) {
              Navigator.pop(context);
              Navigator.pop(context);
              showSnackBar(context: context, msg: state.msg, isError: false);
            }
          },
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Form(
              key: formKey,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  iconTheme: const IconThemeData(
                    color: Colors.white, //change your color here
                  ),
                  title: Text(
                    'أضافة منتج',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  centerTitle: true,
                  flexibleSpace: Container(
                    height: 13.h,
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
                        height: 3.h,
                      ),
                      CustomTextFormFelid(
                          backgroundColor: const Color(0xffF6FAFD),
                          controller: cubit.foodNameController,
                          iconText: const Icon(Bootstrap.github),
                          keyboardType: TextInputType.text,
                          width: 85.w,
                          paddingRightSide: 8.w,
                          paddingLeftSide: 8.w,
                          hintText: 'بكس السعادة',
                          isPassword: false,
                          label: 'اسم المنتج',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "لابد وضع اسم المنتج";
                            } else if (RegExp(r'[0-9]').hasMatch(value)) {
                              return 'الاسم لا يحتوي على أرقام';
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
                              backgroundColor: const Color(0xffF6FAFD),
                              controller: cubit.priceController,
                              keyboardType: TextInputType.number,
                              iconText: const Icon(
                                Bootstrap.currency_dollar,
                                color: Colors.black38,
                              ),
                              width: 40.w,
                              paddingRightSide: 8.w,
                              paddingLeftSide: 0.w,

                              //controller:
                              hintText: '210',
                              isPassword: false,
                              label: 'السعر',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "يجب أضافة السعر";
                                }
                                return null;
                              }),
                          CustomTextFormFelid(
                              backgroundColor: const Color(0xffF6FAFD),
                              controller: cubit.calController,
                              keyboardType: TextInputType.number,
                              iconText: const Icon(
                                Bootstrap.fire,
                                color: Colors.black38,
                              ),
                              paddingRightSide: 0.w,
                              paddingLeftSide: 8.w,
                              width: 40.w,
                              //controller:
                              hintText: '300',
                              isPassword: false,
                              label: 'السعرات',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "يجب كتابة السعرات";
                                }
                                return null;
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomMultiSelects(
                        backgroundColor: const Color(0xffF6FAFD),
                        label: 'الحساسية',
                        hintText: 'اختر الحساسية',
                        items: cubit.allergy,
                        onListChanged: (val) {
                          cubit.allergyList = val;
                          log('$val');
                        },
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomSelect(
                        backgroundColor: const Color(0xffF6FAFD),
                        label: 'النوع',
                        hintText: 'ادخل نوع المنتج',
                        items: const [
                          DropDownItem('none'),
                          DropDownItem('بوكس'),
                          DropDownItem('منتج'),
                        ],
                        onChanged: (p0) {},
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomTextArea(
                        backgroundColor: const Color(0xffF6FAFD),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
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
                      Padding(
                        padding: EdgeInsets.only(right: 8.w, bottom: 1.h),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'صور المنتج',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff103C37)),
                          ),
                        ),
                      ),
                      BlocBuilder<AddCubit, EditState>(
                        builder: (context, state) {
                          return InkWell(
                            onTap: () async => await cubit.pickImage(),
                            child: Container(
                              width: 85.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffF6FAFD),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0.2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: cubit.selectedImage == null
                                  ? Center(
                                      child: Icon(
                                      Icons.add_a_photo,
                                      size: 25.w,
                                      color: Colors.grey,
                                    ))
                                  : Stack(
                                      children: [
                                        Image.file(
                                          cubit.selectedImage!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: IconButton(
                                            icon: Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () {
                                              cubit.selectedImage = null;
                                              cubit.emit(AddInitial());
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (cubit.selectedImage != null) {
                                // Create the product model
                                final product = FoodMenuModel(
                                  id: '',
                                  schoolId: cubit.appModel.empModel!.schoolId,
                                  foodName: cubit.foodNameController.text,
                                  description: cubit.descriptionController.text,
                                  price: num.tryParse(
                                          cubit.priceController.text) ??
                                      0,
                                  category: 'none',
                                  available: true,
                                  cal: int.tryParse(cubit.calController.text) ??
                                      0,
                                  allergy: cubit.allergyList.map(
                                    (e) {
                                      return e.name;
                                    },
                                  ).toList(),
                                  imageUrl: '',
                                );

                                // Add the new product
                                await cubit.addNewProduct(product);
                              } else {
                                showSnackBar(
                                    context: context,
                                    msg: 'يرجى اضافة صورة المنتج',
                                    isError: true);
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
          ),
        );
      }),
    );
  }
}
