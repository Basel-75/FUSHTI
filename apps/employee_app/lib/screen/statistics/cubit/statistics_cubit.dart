
import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/emp_model.dart';
import 'package:get_all_pkg/data/model/school_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit() : super(StatisticsInitial());

  AppModel appModel = getIt.get<AppModel>();

  late final SchoolModel schoolModel = appModel.empModel!.schoolModel;
  late final EmpModel emp = appModel.empModel!;
  List<Map<String, dynamic>> orders = [];

  String schoolId = '${getIt.get<AppModel>().empModel?.schoolId}';

  List<Map<String, dynamic>> salesCount = [];
  int price = 0;
  getTotalPrice() {
    for (var element in salesCount) {
      price += int.parse('${element['total_price']}');
    }
  }

  getOrders() async {
    try {
      emit(LoadingState());
      orders = await SuperMain().getAllOrders();

      emit(DoneState());
    } catch (e) {
      emit(ErrorState(msg: 'حصل خطأ ما يرجى المحاولة مرة اخرى'));
    }
  }

  getSales() async {
    try {
      emit(LoadingState());
      salesCount = await SuperMain().getTotalSalesCount();

      getTotalPrice();
      emit(DoneState());
    } catch (e) {
      emit(ErrorState(msg: 'حصل خطأ ما يرجى المحاولة مرة اخرى'));
      return 0;
    }
  }
}
