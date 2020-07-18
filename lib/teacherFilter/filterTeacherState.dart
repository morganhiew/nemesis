import 'package:equatable/equatable.dart';

abstract class FilterTeacherState {
  const FilterTeacherState();

  @override
  List<Object> get props => [];
}

class FilterTeacherInitial extends FilterTeacherState {}

class FilterTeacherUpdated extends FilterTeacherState {
  final List<FilterTeacherChip> filterTeacherChips;

  const FilterTeacherUpdated({
    this.filterTeacherChips,
  });

  @override
  List<Object> get props => [filterTeacherChips];

  @override
  String toString() =>
      'FilterTeacherUpdated { posts: ${filterTeacherChips.length} }';
}

class FilterTeacherChip {
  final String label;
  final String description;

  const FilterTeacherChip ({this.label, this.description});
}
