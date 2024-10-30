import 'dart:developer';

import 'package:customer_app/component/drop_down_item.dart';
import 'package:customer_app/screen/history/history_screen.dart';
import 'package:customer_app/screen/home/home_screen.dart';
import 'package:customer_app/screen/profile/bloc/profile_bloc.dart';
import 'package:customer_app/screen/profile/edit_user_profile_form.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/container/profile_small_container.dart';
import 'package:customer_app/widget/container/screen_header.dart';
import 'package:customer_app/widget/dropDownMenu/custom_select.dart';
import 'package:customer_app/widget/row/info_container_row.dart';
import 'package:customer_app/widget/row/user_info_row.dart';
import 'package:customer_app/widget/textFormFeild/custom_text_form_felid.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';
import 'package:get_all_pkg/widget/loading_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(GetUserInfoEvent()),
      child: Builder(builder: (context) {
        final bloc = context.read<ProfileBloc>();
        return BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ErrorState) {
              Navigator.pop(context);
              SnackBar(
                content: Text(
                  state.msg,
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: Colors.red,
              );
            }
            if (state is LoadingState) {
              //showLoadingDialog(context: context);
            }
            if (state is ProfileUpdatedState) {
              log("iam lis");
              bloc.add(GetUserInfoEvent());
              // Navigator.pop(context);
            }
          },
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const ScreenHeader(
                      parentName: '',
                      title: 'صفحتي',
                      inHomeScreen: false,
                      childSchollName: '',
                      funds: '',
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 100.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 53.h,
                          left: 70.w,
                          child: Container(
                            width: 25.w,
                            height: 25.w,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 218, 220, 218),
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 0.2, color: Colors.grey)),
                            child: const CircleAvatar(
                                backgroundImage: AssetImage(
                              'assets/image/userprofile.png',
                            )),
                          ),
                        ),
                        //=========Info and edit button==========

                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            return UserInfoRow(
                              name: '${bloc.userName}',
                              schoolNameOrParentPhone: '${bloc.phoneNum}',
                              isParent: true,
                              //update profile info
                              onEdit: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: GlassContainer(
                                      height: 80.w,
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
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: EditUserProfileForm(
                                          usernameController:
                                              bloc.usernameController,
                                          phoneNumController:
                                              bloc.phoneNumController,
                                          onSubmit: () {
                                            bloc.add(UpdateProfileEvent());
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'تم تحديث الملف الشخصي بنجاح'),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              onDelete: () {},
                            );
                          },
                        ),

                        //=============Row of info plan,orders,funds===============
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            return Positioned(
                              top: 8.h,
                              left: 3.w,
                              child: InfoContainerRow(
                                titleOne: 'التابعين',
                                numOne: '${bloc.followersNum}',
                                titleTow: 'الخطط',
                                numTow: '${bloc.planNum}',
                                titleThree: 'المحفظة',
                                numThree: '${bloc.funds}',
                              ),
                            );
                          },
                        ),
                        Positioned(
                          top: 22.h,
                          left: 0.2.w,
                          right: 0.2.w,
                          child: Container(
                            width: 100.w,
                            //height: 30.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 2.w),
                            margin: EdgeInsets.symmetric(horizontal: 3.w),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 223, 214, 214),
                                borderRadius: BorderRadius.circular(11),
                                boxShadow: kElevationToShadow[4],
                                border:
                                    Border.all(width: 0.2, color: Colors.grey)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: const Text(
                                      'الفواتير',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) {
                                          return HistoryScreen();
                                        },
                                      ));
                                    },
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'الشكاوى والأقتراحات',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    onTap: () {},
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                  ListTile(
                                    title: Text(
                                      'عن فسحتي',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    onTap: () {},
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'الأعدادات',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
