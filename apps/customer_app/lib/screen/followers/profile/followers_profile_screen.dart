import 'package:customer_app/component/drop_down_item.dart';
import 'package:customer_app/screen/bottomnavigator/bottom_navigator_screen.dart';
import 'package:customer_app/screen/followers/profile/followers_profile_cubit/followers_profile_cubit.dart';
import 'package:customer_app/screen/followers/edit/edit_followers_screen.dart';
import 'package:customer_app/screen/restrictions/restrictions_screen.dart';
import 'package:customer_app/widget/container/info_container_with_button.dart';
import 'package:customer_app/widget/container/profile_small_container.dart';
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
                          //!provide image later
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

                      //=============Row of info plan,orders,funds===============
                      Positioned(
                        top: 10.h,
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
                        top: 25.h,
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
                        top: 40.h,
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
                        top: 50.h,
                        left: 0.2.w,
                        right: 0.2.w,
                        child: Image.asset('assets/image/profilelogo.png'),
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
