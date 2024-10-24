import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:customer_app/screen/followers/add/add_followers_screen.dart';
import 'package:customer_app/screen/followers/profile/followers_profile_cubit/followers_profile_cubit.dart';
import 'package:customer_app/screen/followers/profile/followers_profile_screen.dart';
import 'package:customer_app/widget/container/child_card.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

import 'package:customer_app/widget/container/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FollowersProfileCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<FollowersProfileCubit>();
        return BlocListener<FollowersProfileCubit, FollowersProfileState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showLoadingDialog(context: context);
            }
            if (state is SuccessState) {
              Navigator.pop(context);
            }
            if (state is ErrorState) {
              Navigator.pop(context);
            }
          },
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddFollowersScreen(),
                  )),
            ),
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
                        children: cubit.appModel.userModel!.childModelList
                            .map(
                              (child) => Padding(
                                padding: EdgeInsets.only(bottom: 3.h),
                                child: ChildCard(
                                    childModel: child,
                                    onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FollowersProfileScreen(
                                                childInfo: child,
                                              ),
                                            )).then(
                                          (value) {
                                            cubit.appModel =
                                                getIt.get<AppModel>();
                                          },
                                        ),
                                    onPressedQR: () async {
                                      await cubit.saveQrCode(childId: child.id);
                                      await cubit.openPdf(
                                          childName: child.name.trim());
                                    }),
                              ),
                            )
                            .toList()

                        // List.generate(
                        //   cubit.appModel.schoolModelList.length,
                        //   (index) {
                        //     return Padding(
                        //       padding: EdgeInsets.only(bottom: 3.h),
                        //       child: ChildCard(
                        //         childModel:
                        //             cubit.appModel.userModel!.childModelList[index],
                        //         onTap: () => Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //               builder: (context) => FollowersProfileScreen(
                        //                 childInfo: cubit.appModel.userModel!
                        //                     .childModelList[index],
                        //               ),
                        //             )).then(
                        //           (value) {
                        //             cubit.appModel = getIt.get<AppModel>();
                        //           },
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // ),
                        )
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
