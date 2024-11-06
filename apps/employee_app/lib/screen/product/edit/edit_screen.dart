import 'dart:developer';

import 'package:employee_app/component/drop_down_item.dart';

import 'package:employee_app/screen/product/edit/cubit/edit_cubit.dart';
import 'package:employee_app/widget/button/custome_button.dart';
import 'package:employee_app/widget/dropDownList/custom_multi_select.dart';
import 'package:employee_app/widget/dropDownList/custom_select.dart';
import 'package:employee_app/widget/textFormField/custom_text_area.dart';
import 'package:employee_app/widget/textFormField/custome_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key, required this.productInfo});
  final FoodMenuModel productInfo;
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => EditCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<EditCubit>();
        cubit.productInfo = productInfo;
        log('${productInfo.toJson()}');
        return BlocListener<EditCubit, EditState>(
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
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    iconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                    title: Text(
                      'تعديل المنتج',
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
                          height: 3.h,
                        ),
                        CustomTextFormFelid(
                            controller: cubit.foodNameController,
                            keyboardType: TextInputType.text,
                            width: 85.w,
                            hintText: productInfo.foodName,
                            isPassword: false,
                            label: 'اسم المنتج',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('يرجى اضافة اسم المنتج'),
                                  backgroundColor: Colors.red,
                                ));
                                return "لابد من وضع اسم المنتج";
                              } else if (RegExp(r'[0-9]').hasMatch(value)) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text('الاسم لا يمكن ان يحتوي على أرقام'),
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
                                controller: cubit.priceController,
                                keyboardType: TextInputType.number,
                                width: 40.w,
                                paddingLeftSide: 0.w,
                                //controller:
                                hintText: '${productInfo.price}',
                                isPassword: false,
                                label: 'السعر',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('يرجى كتابة السعر'),
                                      backgroundColor: Colors.red,
                                    ));
                                    return "يجب كتابة السعر";
                                  }
                                  return null;
                                }),
                            CustomTextFormFelid(
                                controller: cubit.calController,
                                keyboardType: TextInputType.number,
                                paddingRightSide: 0.w,
                                width: 40.w,
                                //controller:
                                hintText: '${productInfo.cal}',
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
                        CustomMultiSelects(
                          label: 'الحساسية',
                          hintText:
                              '${productInfo.allergy ?? 'لا توجد حساسية'}',
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
                          label: 'النوع',
                          hintText: productInfo.category.isEmpty
                              ? 'لا يوجد نوع'
                              : productInfo.category,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('يرجى كتابة  وصف للمنتج'),
                                backgroundColor: Colors.red,
                              ));
                              return "يجب كتابة وصف المنتج";
                            }
                            return null;
                          },
                          //controller:
                          label: 'وصف المنتج',
                          hintText:
                              productInfo.description ?? 'أكتب وصفًا للمنتج...',
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
                        BlocBuilder<EditCubit, EditState>(
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
                                              icon: const Icon(Icons.delete,
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

                                // Edit product
                                await cubit.editCurrentProduct(product);
                              } else {
                                showSnackBar(
                                    context: context,
                                    msg: 'يرجى اضافة صورة المنتج',
                                    isError: true);
                              }
                            },
                            title: 'تعديل المنتج'),
                        SizedBox(
                          height: 3.h,
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
