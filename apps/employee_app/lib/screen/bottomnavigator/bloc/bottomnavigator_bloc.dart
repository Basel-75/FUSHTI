import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottomnavigator_event.dart';
part 'bottomnavigator_state.dart';

class BottomnavigatorBloc
    extends Bloc<BottomnavigatorEvent, BottomnavigatorState> {
  int currentScreenIndex = 0;
  BottomnavigatorBloc() : super(BottomnavigatorInitial()) {
    on<BottomnavigatorEvent>((event, emit) {});
    on<NavigatorBetweenScreenEvent>((event, emit) {
      currentScreenIndex = event.selectedIndex;
      emit(IndexChangeState(index: currentScreenIndex));
    });
  }
}
