import 'dart:developer';

import 'package:employee_app/screen/order/cubit/child_serch_cubit/child_serch_cubit.dart';
import 'package:employee_app/screen/order/order_screen.dart';
import 'package:get_all_pkg/get_all_pkg.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/widget/container/child_card.dart';

class ChildAfterSerachScreen extends StatelessWidget {
  const ChildAfterSerachScreen(
      {super.key, required this.childName, this.childClass});

  final String childName;

  final String? childClass;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChildSerchCubit()
        ..childName = childName
        ..childClass = childClass
        ..getChilds(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<ChildSerchCubit>();
          return BlocListener<ChildSerchCubit, ChildSerchState>(
            listener: (context, state) {
              log("in state");
              if (state is LoadingState) {
                log("in Loding");
                showLoadingDialog(context: context);
              }
              if (state is SuccessState) {
                Navigator.pop(context);
              }
              if (state is ErrorState) {
                Navigator.pop(context);
              }
            },
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: Image.asset('assets/image/mainLogo.png'),
                  centerTitle: true,
                  flexibleSpace: Container(
                    decoration: const ShapeDecoration(
                      shape: SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius.only(
                          bottomLeft: SmoothRadius(
                              cornerRadius: 50, cornerSmoothing: 0.1),
                          bottomRight: SmoothRadius(
                              cornerRadius: 50, cornerSmoothing: 0.1),
                        ),
                      ),
                      color: Color(0xff6FBAE5),
                    ),
                  ),
                  toolbarHeight: 15.h,
                ),
                body: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 6.h,
                        ),
                        BlocBuilder<ChildSerchCubit, ChildSerchState>(
                          builder: (context, state) {
                            return cubit.childLis.isNotEmpty? Column(
                              children: cubit.childLis
                                  .map(
                                    (child) => Padding(
                                      padding: EdgeInsets.only(bottom: 3.h),
                                      child: ChildCard(
                                        childModel: child,
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OrderScreen(childModel: child),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ):const Text('لا يوجد طالب بهذا الاسم');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
