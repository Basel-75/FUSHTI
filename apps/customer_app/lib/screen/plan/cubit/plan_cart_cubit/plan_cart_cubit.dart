import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/meal_plan_item_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'plan_cart_state.dart';

class PlanCartCubit extends Cubit<PlanCartState> {
  PlanCartCubit() : super(PlanCartInitial());

  AppModel appModel = getIt.get<AppModel>();

  DateTime focusedDay = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;

  int dayNume = 0;

  double totalPrice = 0;

// can used when you call superbase with  holidays
  List<DateTime> holidays = [
    DateTime(2024, 10, 25),
    DateTime(2024, 10, 30),
    DateTime(2024, 1, 1),
    DateTime(2024, 2, 14),
    DateTime(2024, 12, 25),
    DateTime.now()
  ];

  onAdd({required MealPlanItemModel mealPlanItemModel}) {
    mealPlanItemModel.quantity += 1;
    emit(QueChnageState());
  }

  onMinus({required MealPlanItemModel mealPlanItemModel}) {
    if (mealPlanItemModel.quantity != 1) {
      mealPlanItemModel.quantity -= 1;

      emit(QueChnageState());
    }
  }

  dateRange({required DateTime? start, required DateTime? end, required day}) {
    log(" here start  $start");
    log(" here end  $end");

    focusedDay = day; //

    startDate = start;
    endDate = end;

    calculateDays();

    emit(DateChnageState());
  }

  upDateDate() {
    emit(DateChnageState());
  }

  calculateDays() {
    dayNume = 0;

    if (startDate != null && endDate != null) {
      for (DateTime date = startDate!;
          date.isBefore(endDate!) || date.isAtSameMomentAs(endDate!);
          date = date.add(const Duration(days: 1))) {
        DateTime normalizedDate = DateTime(date.year, date.month, date.day);

        bool isHoliday = holidays.any((holiday) {
          DateTime normalizedHoliday =
              DateTime(holiday.year, holiday.month, holiday.day);
          return normalizedDate == normalizedHoliday;
        });

        if (date.weekday != DateTime.saturday &&
            date.weekday != DateTime.sunday &&
            !isHoliday) {
          dayNume++;
        }
      }
    }

    log("This is how many business days: $dayNume");
  }

  String calculateCal({required PlanModel planModel}) {
    int totalCal = 0;

    for (var val in planModel.mealPlanItemLis) {
      totalCal += val.foodMenuModel.cal * val.quantity;
    }

    return totalCal.toString();
  }

  String calculateTotal({required PlanModel planModel}) {
    totalPrice = 0;

    for (var val in planModel.mealPlanItemLis) {
      totalPrice += val.foodMenuModel.price * val.quantity;
    }

    return totalPrice.toString();
  }

  payPlan({required PlanModel planModel}) async {
    try {
      emit(LodingState());
      log("user funds :::: ${appModel.userModel!.funds}");
      if (dayNume == 0) {
        emit(ErorrState(msg: "أختر تاريخ"));
        return;
      }

      if (appModel.userModel!.funds < totalPrice) {
        emit(ErorrState(msg: "ليس معك مال"));
        return;
      }

      await SuperMain().payForPlan(
          planModel: planModel,
          stratDate: startDate!,
          endDate: endDate!,
          totalPrice: totalPrice * dayNume);

      log("user funds :::: ${appModel.userModel!.funds}");
      log("very good plan pay");
      emit(DoneState());
    } catch (er) {
      log("$er");
      emit(ErorrState(msg: "there was eorr"));
    }
  }
}
