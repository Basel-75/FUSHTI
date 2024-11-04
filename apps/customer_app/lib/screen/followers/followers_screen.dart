
import 'package:customer_app/screen/followers/add/add_followers_screen.dart';
import 'package:customer_app/screen/followers/profile/followers_profile_cubit/followers_profile_cubit.dart';
import 'package:customer_app/screen/followers/profile/followers_profile_screen.dart';
import 'package:customer_app/widget/container/child_card.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

import 'package:flutter/material.dart';

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
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leadingWidth: 20.w,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.monetization_on,
                    color: Colors.white,
                  ),
                  Text(
                    '${cubit.appModel.userModel?.funds.toString()} رس',
                    style: const TextStyle(color: Colors.white),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
              title: Image.asset('assets/image/mainLogo.png'),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: const ShapeDecoration(
                  shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius.only(
                    bottomLeft:
                        SmoothRadius(cornerRadius: 50, cornerSmoothing: 0.1),
                    bottomRight:
                        SmoothRadius(cornerRadius: 50, cornerSmoothing: 0.1),
                  )),
                  color: Color(0xff6FBAE5),
                ),
              ),
              toolbarHeight: 15.h,
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddFollowersScreen(),
                  )).then(
                (value) {
                  if (value != null) {
                    if (value) {
                      cubit.refreshPage();
                    }
                  }
                },
              ),
            ),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Center(
                  child:
                      BlocBuilder<FollowersProfileCubit, FollowersProfileState>(
                    builder: (context, state) {
                      return Column(
                        children: [
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
                                                  // cubit.appModel =
                                                  //     getIt.get<AppModel>();

                                                  if (value != null) {
                                                    if (value) {
                                                      cubit.refreshPage();
                                                    }
                                                  }
                                                },
                                              ),
                                          onPressedQR: () async {
                                            await cubit.saveQrCode(
                                                childId: child.id);
                                            await cubit.openPdf(
                                                childName: child.name.trim());
                                          }),
                                    ),
                                  )
                                  .toList()
                              )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
