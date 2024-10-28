import 'dart:developer';

import 'package:customer_app/component/drop_down_item.dart';
import 'package:customer_app/screen/bottomnavigator/bottom_navigator_screen.dart';
import 'package:customer_app/screen/followers/profile/followers_profile_cubit/followers_profile_cubit.dart';
import 'package:customer_app/screen/followers/edit/edit_followers_screen.dart';
import 'package:customer_app/screen/restrictions/restrictions_screen.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/container/info_container_with_button.dart';
import 'package:customer_app/widget/container/profile_small_container.dart';
import 'package:customer_app/widget/dropDownMenu/custom_select.dart';
import 'package:customer_app/widget/row/info_container_row.dart';
import 'package:customer_app/widget/row/user_info_row.dart';
import 'package:customer_app/widget/textFormFeild/custom_text_form_felid.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class FollowersProfileScreen extends StatelessWidget {
  final ChildModel? childInfo;
  const FollowersProfileScreen({super.key, required this.childInfo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FollowersProfileCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<FollowersProfileCubit>();
        cubit.countTotal(id: childInfo!.id);
        return BlocListener<FollowersProfileCubit, FollowersProfileState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showLoadingDialog(context: context);
            }
            if (state is SuccessState) {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavigatorScreen(),
                  ));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.msg),
                  backgroundColor: Colors.green,
                ),
              );
            }
            if (state is ErrorState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.msg),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'صفحة التابع',
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
              body: Column(
                children: [
                  const Spacer(),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 100.w,
                        height: 75.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: kElevationToShadow[8],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 70.h,
                        left: 65.w,
                        child: Container(
                          width: 30.w,
                          height: 30.w,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 218, 220, 218),
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 0.2, color: Colors.grey)),
                          //!provide image later
                          child: const CircleAvatar(
                              backgroundImage: AssetImage(
                            'assets/image/kid2.png',
                          )),
                        ),
                      ),
                      //=========Info and edit button==========

                      UserInfoRow(
                        name: childInfo?.name ?? '',
                        schoolNameOrParentPhone:
                            childInfo?.schoolModel.name ?? '',
                        isParent: false,
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditFollowersScreen(
                                childInfo: childInfo,
                              ),
                            ),
                          );
                        },
                        onDelete: () {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.confirm,
                            text: 'هل انت متأكد',
                            confirmBtnText: 'نعم',
                            cancelBtnText: 'لا',
                            confirmBtnColor: Colors.green,
                            onCancelBtnTap: () => Navigator.pop(context),
                            onConfirmBtnTap: () =>
                                cubit.deleteChild(childId: childInfo!.id),
                          );
                        },
                      ),

                      //!status
                      Positioned(
                        top: 6.h,
                        left: 40.w,
                        child: Container(
                          width: 25.w,
                          height: 3.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 113, 228, 132)),
                          child: const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Center(child: Text('يوم مفتوح')),
                          ),
                        ),
                      ),

                      //=============Row of info plan,orders,funds===============
                      Positioned(
                        top: 11.h,
                        left: 3.w,
                        child: InfoContainerRow(
                          titleOne: 'الوجبات',
                          numOne: '${cubit.totalMealsInPlan}',
                          titleTow: 'الخطط',
                          numTow: childInfo?.planList.length.toString() ?? '0',
                          titleThree: 'المصروف',
                          numThree: childInfo?.funds.toString() ?? '0',
                        ),
                      ),
                      Positioned(
                        top: 23.h,
                        left: 0.2.w,
                        right: 0.2.w,
                        child: InfoContainerWithButton(
                          title: 'الوجبات المحظورة',
                          amount: '6',
                          onPressedInfo: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestrictionsScreen(
                                  childId: childInfo!.id,
                                ),
                              )),
                        ),
                      ),
                      Positioned(
                        top: 36.5.h,
                        left: 0.2.w,
                        right: 0.2.w,
                        child: SizedBox(
                          width: 100.w,
                          child: CustomSelect(
                            label: 'الحساسية',
                            hintText: 'عرض الحساسية',
                            items: childInfo!.allergy.isNotEmpty
                                ? List.generate(
                                    childInfo!.allergy.length,
                                    (index) => DropDownItem(
                                          childInfo!.allergy[index],
                                        ))
                                : [const DropDownItem('لا يوجد')],
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 48.h,
                        left: 0.2.w,
                        right: 0.2.w,
                        child: Container(
                          width: 80.w,
                          //height: 30.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 1.w),
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 231, 221, 221),
                              borderRadius: BorderRadius.circular(11),
                              boxShadow: kElevationToShadow[4],
                              border:
                                  Border.all(width: 0.2, color: Colors.grey)),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  'أضافة رصيد',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 2.h,
                                ),
                                onTap: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: GlassContainer(
                                        height: 50.w,
                                        width: 40.h,
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
                                            Colors.lightBlueAccent
                                                .withOpacity(0.05),
                                            Colors.lightBlueAccent
                                                .withOpacity(0.6)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          stops: [0.0, 0.39, 0.40, 1.0],
                                        ),
                                        blur: 15.0,
                                        borderWidth: 1.5,
                                        elevation: 3.0,
                                        isFrostedGlass: true,
                                        shadowColor:
                                            Colors.black.withOpacity(0.20),
                                        alignment: Alignment.center,
                                        frostedOpacity: 0.12,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.h),
                                        child: fondsInfoDailog(
                                          cancelOnPressed: () {
                                            Navigator.pop(context);
                                          },
                                          okOnPressed: () {},
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              ListTile(
                                title: Text(
                                  'يوم مفتوح',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 2.h,
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return OpenDaysBottomSheet(
                                          onPressedButton: () {},
                                          onChangedSwitch: (value) {
                                            if (value == true) {
                                              log('Item is available');
                                            } else {
                                              log('Item is out of stock');
                                            }
                                          },
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return 'Amount cannot be empty';
                                            }
                                            if (double.tryParse(val) == null) {
                                              return 'Please enter a valid number';
                                            }
                                            return null;
                                          },
                                        );
                                      });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Positioned(
                      //   top: 50.h,
                      //   left: 0.2.w,
                      //   right: 0.2.w,
                      //   child: Image.asset('assets/image/profilelogo.png'),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class fondsInfoDailog extends StatelessWidget {
  const fondsInfoDailog({
    super.key,
    this.controller,
    required this.cancelOnPressed,
    required this.okOnPressed,
  });
  final TextEditingController? controller;
  final Function() cancelOnPressed, okOnPressed;
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            const Text(
              'اضافة رصيد الى المحفظة',
              style: TextStyle(color: Colors.white),
            ),
            CustomTextFormFelid(
              controller: controller,
              label: 'المبلغ',
              hintText: '50',
              isPassword: false,
              keyboardType: TextInputType.number,
              // controller: amount,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  onPressed: () => cancelOnPressed,
                  title: 'الغاء',
                  fixedSize: Size(30.w, 5.h),
                  backgroundColor: Colors.red,
                ),
                CustomButton(
                  onPressed: () => okOnPressed,
                  title: 'تأكيد',
                  fixedSize: Size(30.w, 5.h),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ],
        ));
  }
}

class OpenDaysBottomSheet extends StatelessWidget {
  const OpenDaysBottomSheet({
    super.key,
    this.onChangedSwitch,
    this.validator,
    this.controller,
    required this.onPressedButton,
  });
  final Function(dynamic)? onChangedSwitch;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function() onPressedButton;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 30.h,
        decoration: const BoxDecoration(boxShadow: []),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                const Text('الأيام المفتوحة'),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('حالة اليوم'),
                    AdvancedSwitch(
                        initialValue: true,
                        activeColor: Colors.green,
                        inactiveColor: const Color.fromARGB(255, 204, 108, 108),
                        width: 14.w,
                        onChanged: onChangedSwitch),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextFormFelid(
                  validator: validator,
                  horizontal: 0.w,
                  label: 'المصروف',
                  hintText: '25',
                  isPassword: false,
                  keyboardType: TextInputType.number,
                  controller: controller,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: CustomButton(
                    onPressed: onPressedButton,
                    title: 'اضافة التابع',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
