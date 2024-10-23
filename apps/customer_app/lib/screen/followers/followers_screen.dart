import 'package:customer_app/screen/followers/cubit/followers_profile_cubit/followers_profile_cubit.dart';
import 'package:customer_app/screen/followers/followers_profile_screen.dart';
import 'package:customer_app/widget/container/child_card.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

import 'package:customer_app/widget/container/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FollowersProfileCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<FollowersProfileCubit>();

        return Scaffold(
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ScreenHeader(
                    childSchollName: "",
                    funds: getIt.get<AppModel>().userModel!.funds.toString(),
                    inHomeScreen: false,
                    parentName: getIt.get<AppModel>().userModel!.name,
                    title: 'التابعين',
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Column(
                    children: List.generate(
                      cubit.appModel.schoolModelList.length,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 3.h),
                          child: ChildCard(
                            childModel:
                                cubit.appModel.userModel!.childModelList[index],
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FollowersProfileScreen(
                                    childInfo: cubit.appModel.userModel!.childModelList[index],
                                  ),
                                )),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
