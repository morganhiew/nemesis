import 'package:equatable/equatable.dart';

import 'filterTeacherState.dart';

abstract class FilterTeacherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FilterTeacherButtonPressed extends FilterTeacherEvent {
  final FilterTeacherChip chip;

  FilterTeacherButtonPressed(this.chip);

  @override
  List<Object> get props => [chip];

  @override
  String toString() {
    'FilterTeacherButtonPressed { chip: $chip}';
  }

}
