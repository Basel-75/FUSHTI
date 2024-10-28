import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:meta/meta.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit() : super(ScanInitial());

  ChildModel? childModel;

  getchild() async {
    final res = await SuperMain()
        .getChildById(childId: "d89d5dd5-5487-4065-9116-9d1bfe271000");

    childModel = ChildModel.fromJson(res);
  }
}
