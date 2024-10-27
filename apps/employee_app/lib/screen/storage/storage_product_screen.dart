import 'dart:developer';

import 'package:employee_app/screen/storage/cubit/storage_cubit.dart';
import 'package:employee_app/widget/appbar_emp_header.dart';
import 'package:employee_app/widget/button/custome_button.dart';
import 'package:employee_app/widget/container/card_storage.dart';
import 'package:employee_app/widget/textTitle/title_name.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class StorageScreen extends StatelessWidget {
  const StorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StorageCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<StorageCubit>();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BlocListener<StorageCubit, StorageState>(
            listener: (context, state) {
              if (state is LodingState) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              }
              if (state is DoneState) {
                Navigator.pop(context);
                log("very good update adv of food");
              }

              if (state is ErorState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    state.msg,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(19.h),
                child: AppBar(
                  flexibleSpace: EmployeeHeader(
                    isTitle: true,
                    title: 'إدارة المخزون',
                    textSize: 20.sp,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Image.asset('assets/image/storage_img.png'),
                    EmpTitleName(
                      paddingTop: 0.6.h,
                      paddingRight: 2.h,
                      textSize: 18.sp,
                      schoolName: 'منتجاتي',
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    SizedBox(
                      height: 40.h,
                      child: ListView.builder(
                        itemCount: cubit.schoolModel.foodMenuModelList.length,
                        itemBuilder: (context, index) {
                          return CardStorage(
                            isAvailable: cubit
                                .schoolModel.foodMenuModelList[index].available,
                            activeText: 'OOS',
                            inactiveText: 'avail',
                            sizeSwitch: 20.w,
                            onChanged: (value) {
                               cubit.onAdvChange(
                                  foodModel: cubit
                                      .schoolModel.foodMenuModelList[index]);
                              if (value == true) {
                                log('Item is available');
                              } else {
                                log('Item is out of stock');
                              }
                            },
                            image: "assets/image/egg.png",
                            name: cubit
                                .schoolModel.foodMenuModelList[index].foodName,
                          
                          );
                        },
                      ),
                    ),
                    CustomButton(
                        onPressed: () {
                          cubit.updateAdv();
                        },
                        title: "حفظ")
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
