import 'package:customer_app/component/drop_down_item.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class CustomSelect extends StatelessWidget {
  final List<DropDownItem>? items;
  final dynamic Function(DropDownItem?)? onChanged;
  final String label, hintText;
  final String? Function(DropDownItem?)? validator;
  final Color? backgroundColor;
 final DropDownItem? initSchoolDrop;
  const CustomSelect(
      {super.key,
      this.items,
      this.onChanged,
      required this.label,
      required this.hintText,
      this.validator,
      this.backgroundColor,
      this.initSchoolDrop});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff103C37)),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            CustomDropdown<DropDownItem>.search(
              initialItem: initSchoolDrop,
                validator: validator,
                itemsListPadding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: CustomDropdownDecoration(
                  closedFillColor: backgroundColor ?? Colors.white,
                  closedBorder: Border.all(
                      width: 0.8, color: Colors.grey.withOpacity(0.2)),
                  closedShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.2,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                hintText: hintText,
                items: items,
                excludeSelected: false,
                onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}
