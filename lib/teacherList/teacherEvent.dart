import 'package:equatable/equatable.dart';

abstract class TeacherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TeacherFetched extends TeacherEvent {}
