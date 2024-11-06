import 'dart:developer';

import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/user_model.dart';
import 'package:get_all_pkg/data/setup.dart';

mixin UserMix {
  updateChildOpenDay(
      {required double limtFunds,
      required ChildModel childModel,
      required isOpen}) async {
    try {
      await SuperMain().supabase.from("followers").update({
        "daily_limit": limtFunds,
        "is_open_day": isOpen,
      }).eq("id", childModel.id);
    } catch (er) {
      log("$er");
    }
  }

  addfundsChild({required double funds, required ChildModel childModel}) async {
    try {
      AppModel appModel = getIt.get<AppModel>();
      await SuperMain().supabase.rpc("decrement_funds",
          params: {"user_id": appModel.userModel!.id, "amount": funds});

      await SuperMain().supabase.rpc("child_incrment_funds",
          params: {"p_user_id": childModel.id, "p_amount": funds});
    } catch (er) {
      log("$er");
      rethrow;
    }
  }

  updateUserProfile(
      {required String name, required String phone, required String id}) async {
    try {
      await SuperMain()
          .supabase
          .from('users')
          .update({'name': name, 'phone': phone})
          .eq('id', id)
          .select();
    } catch (e) {
      log('$e');
    }
  }

  updateUserProfileImage({required String id, required String imageUrl}) async {
    try {
      final test = await SuperMain()
          .supabase
          .from('users')
          .update({
            'image_url': imageUrl,
          })
          .eq('id', id)
          .select();
      log('$test');
    } catch (e) {
      log('$e');
    }
  }

  getUser({required String id}) async {
    try {
      final response = await SuperMain()
          .supabase
          .from('users')
          .select()
          .eq('id', id)
          .single();
      UserModel user = UserModel.fromJson(response);
      return user;
      log('${user.toJson()}');
    } catch (e) {
      log('$e');
    }
  }

  updateFunds(
      {required String userId,
      required double funds,
      required double oldFund}) async {
    try {
      final res = await SuperMain()
          .supabase
          .from('users')
          .update({'funds': funds + oldFund})
          .eq('id', userId)
          .select();
      log('$res');
    } catch (e) {
      log('$e');
    }
  }

  sendSuggestion(
      {required String senderName,
      required String content,
      required String schoolId}) async {
    try {
      final res = await SuperMain().supabase.from('help_center').insert({
        'sender_name': senderName,
        'school_id': schoolId,
        'message': content
      }).select();
      log('$res');
    } catch (e) {
      log('$e');
    }
  }

  getSuggestion({required String schoolId}) async {
    try {
      final res = await SuperMain()
          .supabase
          .from('help_center')
          .select()
          .eq('school_id', schoolId);
      log('$res');
      return res;
    } catch (e) {
      log('$e');
    }
  }
}
