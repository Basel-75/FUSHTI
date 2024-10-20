import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class PlanItemContainer extends StatelessWidget {
  final String itemName, imagePath;
  final void Function()? onDelete;
  const PlanItemContainer({
    super.key,
    required this.itemName,
    required this.imagePath,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.w,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: kElevationToShadow[4],
        color: Colors.white,
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath),
              const SizedBox(
                height: 10,
              ),
              Text(
                itemName,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Positioned(
            bottom: 13.h,
            left: 14.w,
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.disabled_by_default_outlined,
                  color: Colors.red,
                )),
          ),
        ],
      ),
    );
  }
}
