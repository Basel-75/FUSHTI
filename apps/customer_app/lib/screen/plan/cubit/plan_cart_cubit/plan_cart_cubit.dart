import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:customer_app/screen/product/cubit/product_cubit.dart';
import 'package:get_all_pkg/data/model/meal_plan_item_model.dart';
import 'package:meta/meta.dart';

part 'plan_cart_state.dart';

class PlanCartCubit extends Cubit<PlanCartState> {
  PlanCartCubit() : super(PlanCartInitial());

  DateTime focusedDay = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;

  int dayNume = 0;

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

    // Update the focused day to the end of the selected range or to the start as needed

    focusedDay = day; // Set focusedDay to the end of the range

    startDate = start;
    endDate = end;

    calculateBusinessDays();

    emit(DateChnageState());
  }

  upDateDate() {
    emit(DateChnageState());
  }

  calculateBusinessDays() {
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

  payPlan() {
    try {
      if (dayNume == 0) {
        emit(ErorrState(msg: "chose date"));
      }
    } catch (er) {
      log("$er");
      emit(ErorrState(msg: "there was eorr"));
    }
  }
}
