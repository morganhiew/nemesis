import 'package:equatable/equatable.dart';
import 'package:nemesis/teacherList/teacherClass.dart';

abstract class TeacherState {
  const TeacherState();

  @override
  List<Object> get props => [];
}

class TeacherInitial extends TeacherState {}

class TeacherFailure extends TeacherState {}

class TeacherSuccess extends TeacherState {
  final List<Teacher> teachers;
  final bool hasReachedMax;

  const TeacherSuccess({
    this.teachers,
    this.hasReachedMax,
  });

  TeacherSuccess copyWith({
    List<Teacher> teachers,
    bool hasReachedMax,
  }) {
    return TeacherSuccess(
      teachers: teachers ?? this.teachers,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [teachers, hasReachedMax];

  @override
  String toString() =>
      'TeacherSuccess { posts: ${teachers.length}, hasReachedMax: $hasReachedMax }';
}

class FilterTeacherInitial extends TeacherState {}

class FilterTeacherUpdated extends TeacherState {
  final List<Teacher> teachers;
  final bool hasReachedMax;
  final List<FilterTeacherChip> filterTeacherChips;

  const FilterTeacherUpdated({
    this.filterTeacherChips,
    this.teachers, this.hasReachedMax
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
