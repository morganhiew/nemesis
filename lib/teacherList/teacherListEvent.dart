import 'package:equatable/equatable.dart';
import 'package:nemesis/teacherList/teacherListState.dart';

abstract class TeacherEvent extends Equatable {
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