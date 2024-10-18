import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class BrandRow extends StatelessWidget {
  const BrandRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 47,
          height: 47,
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Color(0xffEFEFEF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Brand(Brands.google),
        ),
        SizedBox(
          width: 8.w,
        ),
        Container(
          width: 47,
          height: 47,
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Color(0xffEFEFEF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Brand(Brands.facebook_circled),
        ),
        SizedBox(
          width: 8.w,
        ),
        Container(
          width: 47,
          height: 47,
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Color(0xffEFEFEF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Brand(Brands.apple_logo),
        ),
      ],
    );
  }
}
