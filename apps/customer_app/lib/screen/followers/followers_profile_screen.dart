import 'package:customer_app/component/drop_down_item.dart';
import 'package:customer_app/widget/container/info_container_with_button.dart';
import 'package:customer_app/widget/container/profile_small_container.dart';
import 'package:customer_app/widget/dropDownMenu/custom_select.dart';
import 'package:customer_app/widget/row/info_container_row.dart';
import 'package:customer_app/widget/row/user_info_row.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class FollowersProfileScreen extends StatelessWidget {
  const FollowersProfileScreen({super.key});

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
                    child: const CircleAvatar(
                        backgroundImage: AssetImage(
                      'assets/image/kid2.png',
                    )),
                  ),
                ),
                //=========Info and edit button==========

                UserInfoRow(
                  name: 'سارة العوفي',
                  schoolNameOrParentPhone: 'النموذجية السادسة والثلاثون',
                  isParent: false,
                  onEdit: () {},
                  onDelete: () {},
                ),

                //=============Row of info plan,orders,funds===============
                Positioned(
                  top: 10.h,
                  left: 3.w,
                  child: const InfoContainerRow(
                    titleOne: 'الوجبات',
                    numOne: '6',
                    titleTow: 'الخطط',
                    numTow: '2',
                    titleThree: 'المصروف',
                    numThree: '20',
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
                    child: const CustomSelect(
                      label: 'الحساسية',
                      hintText: 'عرض الحساسية',
                      items: [
                        DropDownItem('اللوز'),
                        DropDownItem('الفستق'),
                        DropDownItem('الموز'),
                      ],
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
