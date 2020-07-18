import 'package:bloc/bloc.dart';

import 'filterTeacherEvent.dart';
import 'filterTeacherState.dart';


class FilterTeacherBloc extends Bloc<FilterTeacherEvent, FilterTeacherState> {

  FilterTeacherBloc() : super(FilterTeacherInitial());

  @override
  Stream<FilterTeacherState> mapEventToState(FilterTeacherEvent event) async* {
    final currentState = state;
    if (event is FilterTeacherButtonPressed) {
      try {
        if (currentState is FilterTeacherInitial) {
          final List<FilterTeacherChip> chips = [event.chip];
          print('filter teacher initial');
          print(event.chip.label +  event.chip.description);
          yield FilterTeacherAdded(filterTeacherChips: chips);
          return;
        }
        if (currentState is FilterTeacherAdded) {
          currentState.filterTeacherChips.add(event.chip);
          final chips = currentState.filterTeacherChips;
          print('filter teacher added');
          print('length: ' + chips.length.toString());
          yield FilterTeacherAdded(filterTeacherChips: chips);
        }
      } catch (_) {
      }
    }
  }

}
