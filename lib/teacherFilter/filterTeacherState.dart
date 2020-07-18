import 'package:equatable/equatable.dart';

abstract class FilterTeacherState extends Equatable {
  const FilterTeacherState();

  @override
  List<Object> get props => [];
}

class FilterTeacherInitial extends FilterTeacherState {}

class FilterTeacherAdded extends FilterTeacherState {
  final List<FilterTeacherChip> filterTeacherChips;

  const FilterTeacherAdded({
    this.filterTeacherChips,
  });

  @override
  List<Object> get props => [filterTeacherChips];

  @override
  String toString() =>
      'TeacherSuccess { posts: ${filterTeacherChips.length} }';
}

class FilterTeacherChip {
  final String label;
  final String description;

  const FilterTeacherChip ({this.label, this.description});
}
