import 'package:customer_app/component/drop_down_item.dart';
import 'package:customer_app/screen/bottomnavigator/bottom_navigator_screen.dart';
import 'package:customer_app/screen/followers/order_plan/follower_order_plan_screen.dart';
import 'package:customer_app/screen/followers/profile/followers_profile_cubit/followers_profile_cubit.dart';
import 'package:customer_app/screen/followers/edit/edit_followers_screen.dart';
import 'package:customer_app/screen/followers/profile/methods/followers_profile_method.dart';
import 'package:customer_app/screen/profile/profile_screen.dart';
import 'package:customer_app/screen/restrictions/restrictions_screen.dart';
import 'package:customer_app/widget/container/fonds_info_dailog.dart';
import 'package:customer_app/widget/container/info_container_with_button.dart';
import 'package:customer_app/widget/container/open_days_bottomsheet.dart';
import 'package:customer_app/widget/coulmn/followers_tiles_column.dart';
import 'package:customer_app/widget/dropDownMenu/custom_select.dart';
import 'package:customer_app/widget/image/image_handler.dart';
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
      create: (context) => FollowersProfileCubit(childModel: childInfo!),
      child: Builder(builder: (context) {
        final cubit = context.read<FollowersProfileCubit>();
        cubit.countTotal(id: childInfo!.id);
        cubit.getRestrictionFoodList(childId: childInfo!.id);
        return BlocListener<FollowersProfileCubit, FollowersProfileState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showLoadingDialog(context: context);
            }

            if (state is AfterDelState) {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.msg),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context, true);
            }
            if (state is SuccessState) {
              Navigator.pop(context);
              Navigator.pop(context);

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
                backgroundColor: Colors.transparent,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                title: Text(
                  'صفحة التابع',
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
                        bottom: 68.h,
                        left: 66.w,
                        child: Container(
                          width: 28.w,
                          height: 28.w,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.white,
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
                                      ImageHandler(
                                        imagePath: childInfo!.imgPath,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      //=========Info and edit button==========

                      BlocBuilder<FollowersProfileCubit, FollowersProfileState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: UserInfoRow(
                              onAddImage: () async {
                                await cubit.pickImage();
                                await cubit.updateChildImage(
                                    childId: childInfo!.id);
                              },
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
                                ).then(
                                  (value) {
                                    if (value != null) {
                                      if (value) {
                                        cubit.refreshPage();
                                      }
                                    }
                                  },
                                );
                              },
                              onDelete: () {
                                showConfirmDialog(
                                  context: context,
                                  onCancelBtnTap: () => Navigator.pop(context),
                                  onConfirmBtnTap: () => cubit.deleteChild(),
                                );
                              },
                            ),
                          );
                        },
                      ),

                      //status
                      Positioned(
                        top: 8.h,
                        left: 40.w,
                        child: BlocBuilder<FollowersProfileCubit,
                            FollowersProfileState>(
                          builder: (context, state) {
                            return Container(
                              width: 25.w,
                              height: 3.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: cubit.initialValueRaido
                                      ? const Color(0xffA3E9BF)
                                      : const Color(0xff56ecb0b0)),
                              child: const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Center(
                                    child: Text(
                                  'يوم مفتوح',
                                )),
                              ),
                            );
                          },
                        ),
                      ),

                      //=============Row of info plan,orders,funds===============
                      Positioned(
                        top: 13.h,
                        left: 3.w,
                        child: BlocBuilder<FollowersProfileCubit,
                            FollowersProfileState>(
                          builder: (context, state) {
                            return InfoContainerRow(
                              titleOne: 'الوجبات',
                              numOne: '${cubit.totalMealsInPlan}',
                              titleTow: 'الخطط',
                              numTow:
                                  childInfo?.planList.length.toString() ?? '0',
                              titleThree: 'المصروف',
                              numThree: childInfo?.funds.toString() ?? '0',
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 25.h,
                        left: 0.2.w,
                        right: 0.2.w,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: InfoContainerWithButton(
                            title: 'الوجبات المحظورة',
                            amount: '${cubit.restrictionsFood.length}',
                            onPressedInfo: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RestrictionsScreen(
                                    childId: childInfo!.id,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 32.h,
                        left: 0.2.w,
                        right: 0.2.w,
                        child: FollowersTilesColumn(
                          onAddFunds: () => onAddFunds(context, cubit),
                          onAddOpenDays: () {
                            cubit.limtFunds.text =
                                "${cubit.childModel!.dailyLimits}";

                            cubit.initialValueRaido =
                                cubit.childModel!.isOpenDay;

                            onManageOpenDays(context, cubit);
                          },
                          onPressPlanAndOrder: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return FollowerOrderPlanScreen(
                              childModel: childInfo!,
                            );
                          })),
                        ),
                      ),
                      Positioned(
                        top: 56.h,
                        left: 0.2.w,
                        right: 0.2.w,
                        child: SizedBox(
                          width: 100.w,
                          child: BlocBuilder<FollowersProfileCubit,
                              FollowersProfileState>(
                            builder: (context, state) {
                              return CustomSelect(
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
                              );
                            },
                          ),
                        ),
                      ),
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
