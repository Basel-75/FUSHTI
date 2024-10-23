import 'package:customer_app/component/drop_down_item.dart';
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
    return Directionality(
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
                        border: Border.all(width: 0.2, color: Colors.grey)),
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
                  schoolNameOrParentPhone: childInfo?.schoolModel.name ?? '',
                  isParent: false,
                  onEdit: () {},
                  onDelete: () {},
                ),

                //=============Row of info plan,orders,funds===============
                Positioned(
                  top: 10.h,
                  left: 3.w,
                  child: InfoContainerRow(
                    titleOne: 'الوجبات',
                    numOne:childInfo!.planList.isNotEmpty ? childInfo!.planList.first.totalMeals.toString():'0',
                    titleTow: 'الخطط',
                    numTow: childInfo?.planList.length.toString() ?? '0',
                    titleThree: 'المصروف',
                    numThree: childInfo?.funds.toString()??'0',
                  ),
                ),
                Positioned(
                  top: 25.h,
                  left: 0.2.w,
                  right: 0.2.w,
                  child: InfoContainerWithButton(
                    title: 'الوجبات المحظورة',
                    amount: '6',
                    onPressedInfo: () {},
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
                      items:childInfo!.allergy.isEmpty ? List.generate(
                          childInfo!.allergy.length,
                          (index) => DropDownItem(
                                childInfo!.allergy[index],
                              )):[DropDownItem('لا يوجد')],
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
    );
  }
}
