import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nemesis/teacherList/teacherClass.dart';

import 'filterTeacherChipClass.dart';

class TeacherState extends Equatable{
  final List<FilterTeacherChip> filterTeacherChips;
  const TeacherState(this.filterTeacherChips);

  @override
  List<Object> get props => [filterTeacherChips];
}

class TeacherInitial extends TeacherState {
  TeacherInitial({List<FilterTeacherChip> filterTeacherChips}) : super(filterTeacherChips);

  @override
  String toString() =>
      'TeacherInitial';
}

class TeacherFailure extends TeacherState {
  TeacherFailure({List<FilterTeacherChip> filterTeacherChips}) : super(filterTeacherChips);

  @override
  String toString() =>
      'TeacherFailure';
}

class TeacherSuccess extends TeacherState {
  final List<Teacher> teachers;
  final bool hasReachedMax;
  final DocumentSnapshot lastDoc;

  TeacherSuccess({List<FilterTeacherChip> filterTeacherChips, this.teachers, this.hasReachedMax, this.lastDoc}) : super(filterTeacherChips);

  TeacherSuccess copyWith({
    List<Teacher> teachers,
    bool hasReachedMax,
  }) {
    return TeacherSuccess(
      filterTeacherChips: this.filterTeacherChips,
      teachers: teachers ?? this.teachers,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      lastDoc: lastDoc ?? this.lastDoc,
    );
  }

  @override
  List<Object> get props => [teachers, hasReachedMax];

  @override
  String toString() =>
      'TeacherSuccess { posts: ${teachers.length}, hasReachedMax: $hasReachedMax }';
}



