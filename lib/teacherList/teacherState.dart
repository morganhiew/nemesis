import 'package:equatable/equatable.dart';
import 'package:nemesis/teacherList/teacherClass.dart';

abstract class TeacherState extends Equatable {
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
