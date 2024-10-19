import 'package:customer_app/component/job.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class CustomSelect extends StatelessWidget {
  final List<DropDownItem>? items;
  final dynamic Function(DropDownItem?)? onChanged;
  final String label, hintText;
  const CustomSelect({
    super.key,
    this.items,
    this.onChanged,
    required this.label,
    required this.hintText,
  });

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
                itemsListPadding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: CustomDropdownDecoration(
                    closedFillColor: Color(0xffF6F5DF),
                    closedBorder: Border.all(width: 0.8),
                    closedShadow: kElevationToShadow[2]),
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