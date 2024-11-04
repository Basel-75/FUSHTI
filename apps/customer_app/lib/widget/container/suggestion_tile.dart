import 'package:customer_app/component/drop_down_item.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/container/profile_tile.dart';
import 'package:customer_app/widget/dropDownMenu/custom_select.dart';
import 'package:customer_app/widget/textFormFeild/custom_text_form_felid.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class SuggestionTile extends StatelessWidget {
  const SuggestionTile({
    super.key,
    this.onSchoolChanged,
    required this.item,
    this.controller,
    required this.onPressed,
  });

  final Function(DropDownItem?)? onSchoolChanged;
  final List item;
  final TextEditingController? controller;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ProfileTile(
      title: 'الشكاوى و الاقتراحات',
      icon: const Icon(Icons.safety_divider_sharp),
      forLogout: false,
      onTap: () => showBottomSheet(
        context: context,
        builder: (context) => Container(
          width: 100.w,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: kElevationToShadow[4],
          ),
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              Text(
                'الشكاوى و الاقتراحات',
                style:
                    TextStyle(fontSize: 16.sp, color: const Color(0xff546F66)),
              ),
              CustomSelect(
                label: 'المدرسة',
                hintText: 'اختر المدرسة',
                onChanged: onSchoolChanged,
                items: item
                    .map(
                      (school) => DropDownItem(school.name),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 2.h,
              ),
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomTextFormFelid(
                    label: 'النص',
                    hintText: 'لدي مشكلة في ...',
                    isPassword: false,
                    controller: controller,
                  )),
              const Spacer(),
              CustomButton(onPressed: onPressed, title: 'ارسال'),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
