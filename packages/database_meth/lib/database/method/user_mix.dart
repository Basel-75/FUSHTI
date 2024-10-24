import 'dart:developer';

import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/user_model.dart';

mixin UserMix {
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
}
