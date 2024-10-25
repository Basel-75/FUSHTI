import 'package:customer_app/screen/restrictions/cubit/restrictions_cubit.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/container/product_small_container.dart';
import 'package:customer_app/widget/container/restriction_card.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class RestrictionsScreen extends StatelessWidget {
  final String childId;
  const RestrictionsScreen({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestrictionsCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<RestrictionsCubit>();
        cubit.getRestrictionFoodList(childId: childId);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'الوجبات المحظورة',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
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
                SizedBox(
                  height: 77.h,
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
                    child: Column(
                        //'assets/image/boxImage.png'
                        children: List.generate(
                      cubit.restrictionsFood.length,
                      (index) => RestrictionCard(
                          productName: cubit.foodMenuModelList[index].foodName,
                          cal: cubit.foodMenuModelList[index].cal.toString(),
                          imagePath: 'assets/image/boxImage.png',
                          price: cubit.foodMenuModelList[index].price.toString()),
                    )),
                  ),
                ),
                const Spacer(),
                CustomButton(onPressed: () {}, title: 'تأكيد'),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
