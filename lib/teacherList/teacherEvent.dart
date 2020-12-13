import 'package:equatable/equatable.dart';
import 'package:nemesis/teacherList/teacherState.dart';

import 'filterTeacherChipClass.dart';

abstract class TeacherEvent {
  @override
  List<Object> get props => [];
}

class TeacherFetched extends TeacherEvent {}

class FilterTeacherAddButtonPressed extends TeacherEvent {
  final FilterTeacherChip chip;

  FilterTeacherAddButtonPressed(this.chip);

  @override
  List<Object> get props => [chip];

  @override
  String toString() {
    'FilterTeacherAddButtonPressed { chip: $chip}';
  }

}


class FilterTeacherDeleteButtonPressed extends TeacherEvent {
  final FilterTeacherChip chip;

  FilterTeacherDeleteButtonPressed(this.chip);

  @override
  List<Object> get props => [chip];

  @override
  String toString() {
    'FilterTeacherDeleteButtonPressed { chip: $chip}';
  }

}