 import 'dart:developer';

import 'package:customer_app/screen/followers/profile/followers_profile_cubit/followers_profile_cubit.dart';
import 'package:customer_app/widget/container/fonds_info_dailog.dart';
import 'package:customer_app/widget/container/open_days_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

Future<dynamic> onManageOpenDays(
      BuildContext context, FollowersProfileCubit cubit) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return OpenDaysBottomSheet(
            formKey: cubit.formKey,
            initialValueRaido: cubit.initialValueRaido,
            controller: cubit.limtFunds,
            onPressedButton: () {
              cubit.updateOpenDay();
            },
            onChangedSwitch: (value) {
              cubit.initialValueRaido = value;
            },
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Amount cannot be empty';
              }
              if (double.tryParse(val) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          );
        });
  }

  Future<dynamic> onAddFunds(
      BuildContext context, FollowersProfileCubit cubit) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassContainer(
          height: 23.h,
          width: 90.w,
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
              Colors.lightBlueAccent.withOpacity(0.05),
              Colors.lightBlueAccent.withOpacity(0.6)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.39, 0.40, 1.0],
          ),
          blur: 15.0,
          borderWidth: 1.5,
          elevation: 3.0,
          isFrostedGlass: true,
          shadowColor: Colors.black.withOpacity(0.20),
          alignment: Alignment.center,
          frostedOpacity: 0.12,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: fondsInfoDailog(
            formKey: cubit.formKey,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Amount cannot be empty';
              }

              if (double.tryParse(val) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
            controller: cubit.fundsCon,
            cancelOnPressed: () {
              log("in caneel of page");
              Navigator.pop(context);
            },
            okOnPressed: () {
              log("in ok of page");

              cubit.addFundstoChild();
            },
          ),
        ),
      ),
    );
  }

