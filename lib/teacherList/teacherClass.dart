import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Teacher extends Equatable {
  final String id;
  final String name;
  final String description;
  final bool liked;
  final List<int> subjects;

  const Teacher ({this.id, this.name, this.description, this.liked, this.subjects});

  @override
  List<Object> get props => [id, name, description, liked];

}

//// ignore: non_constant_identifier_names
//final List<Teacher> teachersList = [
//  Teacher('1', 'hi', true),
//  Teacher('2', 'hiiii', false),
//  Teacher('3', 'hihihi', true),
//  Teacher('4', 'hihi', true),
//  Teacher('5', 'hiiiii', false),
//  Teacher('6', 'hiiih', false),
//  Teacher('7', 'mu', true),
//  Teacher('8', 'afe', true),
//  Teacher('9', 'seaef', false),
//  Teacher('10', 'seffe', true),
//  Teacher('11', 'saeffe', false),
//];