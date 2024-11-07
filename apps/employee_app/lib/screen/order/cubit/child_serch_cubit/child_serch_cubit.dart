import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:meta/meta.dart';

part 'child_serch_state.dart';

class ChildSearchCubit extends Cubit<ChildSearchState> {
  ChildSearchCubit() : super(ChildSerchInitial());

  late final String childName;

  String? childClass;

  List<ChildModel> childLis = [];

  getChilds() async {
    await Future.delayed(const Duration(milliseconds: 300));

    emit(LoadingState());

    try {
      childLis = await SuperMain()
          .getAllChildernSerch(name: childName, childClass: childClass);

      emit(SuccessState());
    } catch (er) {
      emit(ErrorState(msg: "حصل خطأ ما يرجى المحاولة لاحقا"));
    }
  }
}
