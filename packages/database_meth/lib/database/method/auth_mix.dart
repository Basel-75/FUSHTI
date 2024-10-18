import 'dart:developer';

import 'package:database_meth/database/super.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

mixin AuthMix on Super {
  createUser({required String email, required String phone}) async {
    try {
      log("${phone}");
      await supabase.auth.signInWithOtp(email: email, phone: "+966${phone.substring(1)}");
    } catch (er) {
      log("$er");
      throw "$er";
    }
  }

  verifyOtp({
    required String email,
    required String otp,
    required String? name,
  }) async {
    try {
      final auth = await supabase.auth
          .verifyOTP(type: OtpType.email, email: email, token: otp);

      if (name != null) {
        final customer = await supabase
            .from('users')
            .insert({"name": name, 'auth_id': auth.user!.id}).select();

        // final user = UserModel(
        //     customerId: customer[0]['customer_id'],
        //     email: auth.user!.email!,
        //     firstName: customer[0]['first_name'],
        //     lastName: customer[0]['last_name']);

        // authLocator.get<AuthLayer>().saveAuth(userData: user);
      } else {
        final customer =
            await supabase.from('users').select().eq('auth_id', auth.user!.id);

        // final user = UserModel(
        //     customerId: customer[0]['customer_id'],
        //     email: auth.user!.email!,
        //     firstName: customer[0]['first_name'],
        //     lastName: customer[0]['last_name']);

        // productLocator.get<AuthLayer>().saveAuth(userData: user);
      }
    } catch (er) {
      throw "$er";
    }
  }
}
