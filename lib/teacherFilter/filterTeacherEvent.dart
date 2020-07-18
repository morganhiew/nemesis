import 'package:equatable/equatable.dart';

import 'filterTeacherState.dart';

abstract class FilterTeacherEvent {
  @override
  List<Object> get props => [];
}

class FilterTeacherAddButtonPressed extends FilterTeacherEvent {
  final FilterTeacherChip chip;

  FilterTeacherAddButtonPressed(this.chip);

  @override
  List<Object> get props => [chip];

  @override
  String toString() {
    'FilterTeacherAddButtonPressed { chip: $chip}';
  }

}


class FilterTeacherDeleteButtonPressed extends FilterTeacherEvent {
  final FilterTeacherChip chip;

  FilterTeacherDeleteButtonPressed(this.chip);

  @override
  List<Object> get props => [chip];

  @override
  String toString() {
    'FilterTeacherDeleteButtonPressed { chip: $chip}';
  }

}