import 'package:bloc/bloc.dart';

import 'filterTeacherEvent.dart';
import 'filterTeacherState.dart';


class FilterTeacherBloc extends Bloc<FilterTeacherEvent, FilterTeacherState> {

  FilterTeacherBloc() : super(FilterTeacherInitial());

  @override
  Stream<FilterTeacherState> mapEventToState(FilterTeacherEvent event) async* {
    final currentState = state;
    if (event is FilterTeacherAddButtonPressed) {
      try {
        if (currentState is FilterTeacherInitial) {
          final List<FilterTeacherChip> chips = [event.chip];
          print('filter teacher initial');
          print(event.chip.label +  event.chip.description);
          yield FilterTeacherUpdated(filterTeacherChips: chips);
          return;
        }
        if (currentState is FilterTeacherUpdated) {
          currentState.filterTeacherChips.add(event.chip);
          final chips = currentState.filterTeacherChips;
          print('filter teacher added');
          print('length: ' + chips.length.toString());
          yield FilterTeacherUpdated(filterTeacherChips: chips);
        }
      } catch (_) {
      }
    }
    else if (event is FilterTeacherDeleteButtonPressed) {
      if (currentState is FilterTeacherUpdated) {
        List<FilterTeacherChip> newChipList = new List();
        print('chip label: ' + event.chip.label);
        for (var i = 0; i < currentState.filterTeacherChips.length; i++) {
          print('iterating list: ' + currentState.filterTeacherChips[i].label.toString());
          if (event.chip.label != currentState.filterTeacherChips[i].label.toString()) {
            newChipList.add(currentState.filterTeacherChips[i]);
          }
        }
        print('filter teacher updated');
        yield FilterTeacherUpdated(filterTeacherChips: newChipList);
      }
    }
  }

}
