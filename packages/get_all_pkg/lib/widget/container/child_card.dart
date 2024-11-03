
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/get_all_pkg.dart';
import 'package:get_all_pkg/widget/image/image_handler.dart';

class ChildCard extends StatelessWidget {
  final ChildModel childModel;
  final Function()? onTap;
  final void Function()? onPressedQR;
  const ChildCard(
      {super.key, required this.childModel, this.onTap, this.onPressedQR});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90.w,
        height: 12.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffFFFFFF),
            boxShadow: kElevationToShadow[4]),
        child: Row(
          children: [
            Container(
              width: 33.w,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child:ImageHandler(imagePath: childModel.imgPath,errorWidget: Image.asset(
                "assets/image/child_img.png",
                fit: BoxFit.fill,
              ),) 
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 2.h, right: 3.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person_outline),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          childModel.name,
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.2.h,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.school_outlined),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(
                          childModel.schoolModel.name,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                IconButton(
                    onPressed: onPressedQR,
                    icon: Icon(Iconsax.scan_barcode_outline)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
