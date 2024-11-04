import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/feedback_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  List<FeedbackModel> messages = [];
  FeedbackCubit() : super(FeedbackInitial());

  String schoolId = '${getIt.get<AppModel>().empModel?.schoolId}';
  displayFeedback() async {
    try {
      emit(LoadingState());
      final res = await SuperMain().getSuggestion(schoolId: schoolId);
      log('1111111111111111');
      log('${res.runtimeType}');
      for (var element in res) {
        messages.add(FeedbackModel.fromJson(element));
        log(element.toString());
      }

      emit(SuccessState());
    } catch (e) {
      log('$e');
      emit(ErrorState(msg: 'حصل خطأ ما يرجى المحاولة مرة اخرى'));
    }
  }
}
