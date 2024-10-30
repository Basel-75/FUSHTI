import 'dart:developer';

import 'package:customer_app/component/drop_down_item.dart';
import 'package:customer_app/screen/bottomnavigator/bottom_navigator_screen.dart';
import 'package:customer_app/screen/followers/profile/followers_profile_cubit/followers_profile_cubit.dart';
import 'package:customer_app/screen/followers/edit/edit_followers_screen.dart';
import 'package:customer_app/screen/restrictions/restrictions_screen.dart';
import 'package:customer_app/widget/container/fonds_info_dailog.dart';
import 'package:customer_app/widget/container/info_container_with_button.dart';
import 'package:customer_app/widget/container/open_days_bottomsheet.dart';
import 'package:customer_app/widget/dropDownMenu/custom_select.dart';
import 'package:customer_app/widget/row/info_container_row.dart';
import 'package:customer_app/widget/row/user_info_row.dart';
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
            if (state is SuccessUpdateImageState) {
              Navigator.pop(context);
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
            if (state is ErrorUpdateImageState) {
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
                          //Image
                          child: BlocBuilder<FollowersProfileCubit,
                              FollowersProfileState>(
                            builder: (context, state) {
                              return CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: ClipOval(
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.network(
                                        childInfo!.imgPath,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            Image.asset('assets/image/kid2.png',
                                                fit: BoxFit.cover),
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20.w,
                        child: IconButton(
                            onPressed: () async {
                              await cubit.pickImage();
                              await cubit.updateChildImage(
                                  childId: childInfo!.id);
                            },
                            icon: const Icon(Icons.add_a_photo)),
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
                                //! button dialog
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
                                          //controller: ,
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
                                //! bottomsheet activate plan
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
