import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStatee> {
  AuthCubit() : super(AuthInitial());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final db = SuperMain().supabase;
  TextEditingController emailCon = TextEditingController();
  TextEditingController nameCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();

  singup() async {
    try {
      emit(LoadingState());
      if (formKey.currentState!.validate()) {
        await SuperMain().createUser(email: emailCon.text,phone: phoneCon.text);

        emit(SuccessState());
      } else {
        emit(NoLoadingState());
      }
    } catch (er) {
      emit(ErrorState(msg: er.toString()));
    }
  }
}
