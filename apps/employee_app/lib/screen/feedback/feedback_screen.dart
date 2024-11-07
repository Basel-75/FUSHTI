
import 'package:employee_app/screen/feedback/cubit/feedback_cubit.dart';
import 'package:employee_app/widget/container/card_feedback.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedbackCubit()..displayFeedback(),
      child: Builder(builder: (context) {
        final cubit = context.read<FeedbackCubit>();
        return BlocListener<FeedbackCubit, FeedbackState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showLoadingDialog(context: context);
            }
            if (state is ErrorState) {
              showSnackBar(context: context, msg: state.msg, isError: true);
            }
            if (state is SuccessState) {}
          },
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    iconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                    title: Text(
                      'الشكاوى و الاقتراحات',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    centerTitle: true,
                    flexibleSpace: Container(
                      //height: 15.h,
                      decoration: const BoxDecoration(
                        color: Color(0xff6FBAE5),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        ),
                      ),
                    ),
                    toolbarHeight: 11.h,
                  ),
                  body: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: BlocBuilder<FeedbackCubit, FeedbackState>(
                      builder: (context, state) {
                        return Column(
                          children: cubit.messages
                              .map(
                                (e) => CartFeedBack(
                                    name: '${e.senderName}',
                                    description: '${e.message}',
                                    image: 'assets/image/mainLogo.png'),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ))),
        );
      }),
    );
  }
}
