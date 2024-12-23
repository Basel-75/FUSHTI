import 'package:database_meth/database/super.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/emp_model.dart';
import 'package:get_all_pkg/data/model/user_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

mixin AuthMix on Super {
  getEmpUser() async {
    try {
      final res = await SuperMain()
          .supabase
          .from("emp")
          .select()
          .eq("id", "29cb5287-4c69-47fb-ac68-5cf71de183b5");

      getIt.get<AppModel>().empModel = EmpModel.fromJson(res[0]);
    } catch (er) {}
  }

  getUserTempData() async {
    try {
      final res = await SuperMain()
          .supabase
          .from("users")
          .select()
          .eq("id", "35d625c6-a6b1-4089-a638-f87c776aab2b");

      getIt.get<AppModel>().userModel = UserModel.fromJson(res[0]);
    } catch (er) {}
  }

  createUser({required String email}) async {
    try {
      // log("${phone}");
      await supabase.auth.signInWithOtp(email: email);
    } catch (er) {}
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
      final user = await supabase.from('users').insert(
          {"name": name, 'auth_id': auth.user!.id, "phone": phone}).select();

      getIt.get<AppModel>().saveUser(UserModel.fromJson(user[0]));
    } else {
      final user =
          await supabase.from('users').select().eq('auth_id', auth.user!.id);

      getIt.get<AppModel>().saveUser(UserModel.fromJson(user[0]));
    }
  }
}
