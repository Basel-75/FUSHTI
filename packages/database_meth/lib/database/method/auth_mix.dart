import 'dart:developer';

import 'package:database_meth/database/super.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/user_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

mixin AuthMix on Super {
  createUser({required String email}) async {
    try {
      // log("${phone}");
      await supabase.auth.signInWithOtp(email: email);
    } catch (er) {
      log("$er");
      throw "$er";
    }
  }

  verifyOtp(
      {required String email,
      required String otp,
      required String? name,
      required String? phone}) async {
    // try {
      final auth = await supabase.auth
          .verifyOTP(type: OtpType.email, email: email, token: otp);

      if (name != null && phone != null) {
        log("in if");
        final user = await supabase.from('users').insert(
            {"name": name, 'auth_id': auth.user!.id, "phone": phone}).select();

        // final user = UserModel(
        //     customerId: customer[0]['customer_id'],
        //     email: auth.user!.email!,
        //     firstName: customer[0]['first_name'],
        //     lastName: customer[0]['last_name']);

        // authLocator.get<AuthLayer>().saveAuth(userData: user);
        getIt.get<AppModel>().saveUser(UserModel.fromJson(user[0]));
      } else {
        log("in else");
        final user =
            await supabase.from('users').select().eq('auth_id', auth.user!.id);

        // final user = UserModel(
        //     customerId: customer[0]['customer_id'],
        //     email: auth.user!.email!,
        //     firstName: customer[0]['first_name'],
        //     lastName: customer[0]['last_name']);

        getIt.get<AppModel>().saveUser(UserModel.fromJson(user[0]));
      }
    // }
    
    //  catch (er) {
    //   throw "$er";
    // }
  }
}
