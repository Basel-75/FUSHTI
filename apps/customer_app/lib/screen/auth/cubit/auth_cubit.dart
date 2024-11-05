import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:flutter/widgets.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStatee> {
  AuthCubit() : super(AuthInitial());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final db = SuperMain().supabase;
  TextEditingController emailCon = TextEditingController();
  TextEditingController nameCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();

  String otp = "";

  singup() async {
    try {
      emit(LoadingState());
      if (formKey.currentState!.validate()) {
        log(phoneCon.text);
        await SuperMain().createUser(email: emailCon.text);

        emit(SuccessState());
      } else {
        emit(NoLoadingState());
      }
    } catch (er) {
      emit(ErrorState(msg: er.toString()));
    }
  }

  otpCheck({
    required String email,
    required String? name,
    required String? phone,
  }) async {
    emit(LoadingState());
    if (otp.isEmpty) {
      emit(ErrorState(msg: "ادخل رمز التحقق"));
      return;
    }

    await SuperMain()
        .verifyOtp(email: email, otp: otp, name: name, phone: phone);

    emit(SuccessState());
  }
}
