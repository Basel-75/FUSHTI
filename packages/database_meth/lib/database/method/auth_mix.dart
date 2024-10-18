import 'dart:developer';

import 'package:database_meth/database/super.dart';

mixin AuthMix on Super {
  createUser({required String email, required String phone}) async {
    try {
      await supabase.auth.signInWithOtp(email: email, phone: phone);
    } catch (er) {
      log("$er");
      throw "$er";
    }
  }
}
