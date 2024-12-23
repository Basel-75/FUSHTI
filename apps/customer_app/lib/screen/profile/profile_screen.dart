import 'package:customer_app/screen/auth/login_screen.dart';
import 'package:customer_app/screen/profile/bloc/profile_bloc.dart';
import 'package:customer_app/widget/container/profile_tile.dart';
import 'package:customer_app/widget/container/show_dialog_pay_widget.dart';
import 'package:customer_app/widget/container/suggestion_tile.dart';
import 'package:customer_app/widget/coulmn/edit_user_profile_form.dart';
import 'package:customer_app/widget/row/info_container_row.dart';
import 'package:customer_app/widget/row/user_info_row.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final bloc = context.read<ProfileBloc>();
      bloc.add(GetUserInfoEvent());
      return BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ErrorState) {
            Navigator.pop(context);
            SnackBar(
              content: Text(
                state.msg,
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: Colors.red,
            );
          }
          if (state is LoadingState) {
            showLoadingDialog(context: context);
          }
          if (state is ProfileUpdatedState) {
            bloc.add(GetUserInfoEvent());
          }
          if (state is SussesState) {
            Navigator.pop(context);
            Navigator.pop(context);
            showSnackBar(context: context, msg: state.msg, isError: false);
          }
          if (state is SussesPayState) {
            Navigator.pop(context);
          }
          if (state is SussesUpdateFundsState) {
            showSnackBar(context: context, msg: state.msg, isError: false);
          }
        },
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
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
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 7.h,
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 100.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 53.h,
                          left: 70.w,
                          child: Container(
                            width: 25.w,
                            height: 25.w,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 218, 220, 218),
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 0.2, color: Colors.grey)),
                            child: const CircleAvatar(
                                backgroundImage: AssetImage(
                              'assets/image/userprofile.png',
                            )),
                          ),
                        ),
                        //=========Info and edit button==========

                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: UserInfoRow(
                                onAddImage: () {},
                                name: '${bloc.userName}',
                                schoolNameOrParentPhone: '${bloc.phoneNum}',
                                isParent: true,
                                //update profile info
                                onEdit: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: GlassContainer(
                                        height: 80.w,
                                        width: 40.h,
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.white.withOpacity(0.40),
                                            Colors.white.withOpacity(0.10)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderGradient: LinearGradient(
                                          colors: [
                                            Colors.white.withOpacity(0.60),
                                            Colors.white.withOpacity(0.10),
                                            Colors.lightBlueAccent
                                                .withOpacity(0.05),
                                            Colors.lightBlueAccent
                                                .withOpacity(0.6)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          stops: const [0.0, 0.39, 0.40, 1.0],
                                        ),
                                        blur: 15.0,
                                        borderWidth: 1.5,
                                        elevation: 3.0,
                                        isFrostedGlass: true,
                                        shadowColor:
                                            Colors.black.withOpacity(0.20),
                                        alignment: Alignment.center,
                                        frostedOpacity: 0.12,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.h),
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: EditUserProfileForm(
                                            usernameController:
                                                bloc.usernameController,
                                            phoneNumController:
                                                bloc.phoneNumController,
                                            onSubmit: () {
                                              bloc.add(UpdateProfileEvent());
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'تم تحديث الملف الشخصي بنجاح'),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                onDelete: () {},
                              ),
                            );
                          },
                        ),

                        //=============Row of info plan,orders,funds===============
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            return Positioned(
                              top: 8.h,
                              left: 3.w,
                              child: InfoContainerRow(
                                titleOne: 'التابعين',
                                numOne: '${bloc.followersNum}',
                                titleTow: 'الخطط',
                                numTow: '${bloc.planNum}',
                                titleThree: 'المحفظة',
                                numThree: '${bloc.funds}',
                              ),
                            );
                          },
                        ),
                        Positioned(
                          top: 22.h,
                          left: 0.2.w,
                          right: 0.2.w,
                          child: Column(
                            children: [
                              BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, state) {
                                  return ProfileTile(
                                      title: 'شحن المحفظة',
                                      icon: const Icon(
                                          Icons.monetization_on_rounded),
                                      forLogout: false,
                                      onTap:
                                          () async => await showDialogPayWidget(
                                                context: context,
                                                priceTotal:
                                                    bloc.amountController,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  bloc.add(PaymentEvent());

                                                  if (state is SussesPayState) {
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 200),
                                                        () {
                                                      if (context.mounted) {
                                                        showBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    Container(
                                                                      width:
                                                                          100.w,
                                                                      height:
                                                                          70.h,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12),
                                                                      ),
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                6.w,
                                                                            vertical: 2.h),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              SizedBox(
                                                                                height: 4.h,
                                                                              ),
                                                                              Image.asset('assets/image/mainLogo.png'),
                                                                              CreditCard(locale: const Localization.ar(), config: state.paymentConfig, onPaymentResult: (PaymentResponse paymentResponse) => bloc.add(CheckPaymentEvent(paymentResponse: paymentResponse))),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ));
                                                      }
                                                    });
                                                  }
                                                },
                                              ));
                                },
                              ),
                              // ProfileTile(
                              //   title: 'الفواتير',
                              //   icon: const Icon(Icons.book_outlined),
                              //   forLogout: false,
                              //   onTap: () => Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) =>
                              //             const HistoryScreen(),
                              //       )),
                              // ),
                              SuggestionTile(
                                item: bloc.appModel.schoolModelList,
                                controller: bloc.messageController,
                                onPressed: () => bloc
                                        .messageController!.text.isNotEmpty
                                    ? bloc.add(SendMessagesEvent(
                                        senderName:
                                            '${bloc.appModel.userModel?.name}',
                                        schoolId: '${bloc.schoolId}',
                                        content:
                                            '${bloc.messageController?.text}'))
                                    : showSnackBar(
                                        context: context,
                                        msg: 'رسالة فارغة',
                                        isError: true),
                                onSchoolChanged: (p0) =>
                                    bloc.schoolName = p0?.name,
                              ),
                              ProfileTile(
                                title: 'عن فسحتي',
                                icon: const Icon(Icons.info_outline_rounded),
                                forLogout: false,
                                onTap: () => QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.info,
                                    title: '👋 مرحبًا بك في فسحتي',
                                    text:
                                        '\n🍽️ فسحتي هو خيارك الأمثل لتنظيم وجبات ابنائك بكل يسر و سهولة. نحرص في فسحتي على حل مشاكل الأبناء و الآباء في المقاصف المدرسية حيث نوفر للأب خيار إدارة وجبات أبنائهم و نوفر للأبناء حل لمشاكل المصروف. نسعد باقتراحاتكم و نعمل من أجل رضاكم.\n\n❤️ فريق فسحتي',
                                    confirmBtnText: 'حسنا'),
                              ),
                              ProfileTile(
                                  title: 'تسجيل الخروج',
                                  icon: const Icon(Icons.exit_to_app_rounded),
                                  forLogout: true,
                                  backgroundColor: const Color(0x56ECB0B0),
                                  onTap: () => showConfirmDialog(
                                        context: context,
                                        onCancelBtnTap: () =>
                                            Navigator.pop(context),
                                        onConfirmBtnTap: () async {
                                          await Supabase.instance.client.auth
                                              .signOut();
                                          if (context.mounted) {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginScreen(),
                                                ));
                                          }
                                        },
                                      )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
