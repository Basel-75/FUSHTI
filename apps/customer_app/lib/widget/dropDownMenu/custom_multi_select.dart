import 'package:customer_app/component/drop_down_item.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class CustomMultiSelect extends StatelessWidget {
  final List<DropDownItem>? items;
  final dynamic Function(List<DropDownItem>)? onListChanged;
  final String label, hintText;
  final Color? backgroundColor;
  final List<DropDownItem>? initialItems;
  const CustomMultiSelect(
      {super.key,
      this.items,
      this.onListChanged,
      required this.label,
      required this.hintText,
      this.backgroundColor,
      this.initialItems});

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
            CustomDropdown<DropDownItem>.multiSelectSearch(
                initialItems: initialItems,
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
                onListChanged: onListChanged),
          ],
        ),
      ),
    );
  }
}
