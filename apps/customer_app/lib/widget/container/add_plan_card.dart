import 'package:customer_app/widget/container/product_small_container.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class AddPlanCard extends StatelessWidget {
  final String productName, quantity, price, cal, imagePath;
  final Function() onAdd, onMinus;
  final Function()? onDelete;
  final bool withoutDelete;
  const AddPlanCard({
    super.key,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.cal,
    required this.onAdd,
    required this.onMinus,
    this.onDelete,
    required this.imagePath,
    required this.withoutDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      margin: EdgeInsets.symmetric(vertical: 1.h),
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: kElevationToShadow[4],
        color: Colors.white,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
            child: Image.asset(
              imagePath,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                productName,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: onAdd,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xffC8E5F5),
                      ),
                      child: const Icon(Iconsax.add_outline),
                    ),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    quantity,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  InkWell(
                    onTap: onMinus,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xffC8E5F5),
                      ),
                      child: const Icon(Iconsax.minus_outline),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              !withoutDelete
                  ? IconButton(
                      onPressed: onDelete,
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ))
                  : const Text(''),
              Row(
                children: [
                  ProductSmallContainer(
                    isForCal: false,
                    amount: price,
                    isCallWithText: false,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  ProductSmallContainer(
                    isForCal: true,
                    amount: cal,
                    isCallWithText: false,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
