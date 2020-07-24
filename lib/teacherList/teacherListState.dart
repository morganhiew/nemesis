import 'package:equatable/equatable.dart';
import 'package:nemesis/teacherList/teacherClass.dart';

class TeacherState {
  final List<FilterTeacherChip> filterTeacherChips;
  const TeacherState(this.filterTeacherChips);

  @override
  List<Object> get props => [];
}

class TeacherInitial extends TeacherState {
  TeacherInitial({List<FilterTeacherChip> filterTeacherChips}) : super(filterTeacherChips);
}

class TeacherFailure extends TeacherState {
  TeacherFailure({List<FilterTeacherChip> filterTeacherChips}) : super(filterTeacherChips);
}

class TeacherSuccess extends TeacherState {
  final List<Teacher> teachers;
  final bool hasReachedMax;

  TeacherSuccess({List<FilterTeacherChip> filterTeacherChips, this.teachers, this.hasReachedMax}) : super(filterTeacherChips);

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


class FilterTeacherChip {
  final String label;
  final String description;

  const FilterTeacherChip ({this.label, this.description});
}
