import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:nemesis/teacherList/teacherClass.dart';
import 'package:nemesis/teacherList/teacherListEvent.dart';
import 'package:nemesis/teacherList/teacherListState.dart';


class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {

  TeacherBloc() : super(TeacherInitial(filterTeacherChips: []));

  @override
  Stream<TeacherState> mapEventToState(TeacherEvent event) async* {
    print('bloc called');
    final currentState = state;
    List<FilterTeacherChip> currentChip = state.filterTeacherChips;

    // original bloc for teacher filter
    if (event is FilterTeacherAddButtonPressed) {
      try {
        FilterTeacherChip selectedChip;
        if (event is FilterTeacherAddButtonPressed) {
          selectedChip = event.chip;
        }
        if (currentChip == null) {
          currentChip = [selectedChip];
        } else {
          currentChip.add(selectedChip);
        }
        print('filter teacher added');
        print('length: ' + currentChip.length.toString());
      } catch (_) {
      }
    }
    else if (event is FilterTeacherDeleteButtonPressed) {
        List<FilterTeacherChip> newChipList = new List();
        print('chip label: ' + event.chip.label);
        for (var i = 0; i < currentState.filterTeacherChips.length; i++) {
          print('iterating list: ' + currentChip[i].label.toString());
          if (event.chip.label != currentChip[i].label.toString()) {
            newChipList.add(currentChip[i]);
          }
        }
        print('filter teacher updated');
        currentChip = newChipList;
    }

    if (event is TeacherFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is TeacherInitial) {
          print('teacher bloc initial');
          final teachers = await _fetchPosts(0, 6);
          yield TeacherSuccess(filterTeacherChips: currentChip, teachers: teachers, hasReachedMax: false);
        }
        else if (currentState is TeacherSuccess) {
          final posts = state.filterTeacherChips.length > 0 ?
          await _fetchPostsB(currentState.teachers.length, 6): await _fetchPosts(currentState.teachers.length, 6);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : TeacherSuccess(filterTeacherChips: currentChip,
            teachers: currentState.teachers + posts,
            hasReachedMax: false,
          );
        }
      } catch (_) {
        yield TeacherFailure();
      }
    } else if ((event is FilterTeacherAddButtonPressed || event is FilterTeacherDeleteButtonPressed)) {
      try {
        print('teacher bloc re initialise');
        yield TeacherInitial();
        final teachers = await _fetchPostsB(0, 6);
        yield TeacherSuccess(filterTeacherChips: currentChip, teachers: teachers, hasReachedMax: false);
      } catch (_) {
        yield TeacherFailure();
      }
    }

  }

  bool _hasReachedMax(TeacherState state) =>
      state is TeacherSuccess && state.hasReachedMax;

  _fetchPosts(int startIndex, int limit) async {
    final List<Teacher> teachersList = [
      Teacher(name:'1', description:'hi', liked: true),
      Teacher(name:'2', description: 'hiiii', liked: false),
      Teacher(name:'3', description: 'hihihi', liked: true),
      Teacher(name:'4', description: 'hihi', liked: true),
      Teacher(name:'5', description: 'hiiiii', liked: false),
      Teacher(name:'6', description: 'hiiih', liked: false),
      Teacher(name:'7', description: 'mu', liked: true),
      Teacher(name:'8', description: 'afe', liked: true),
      Teacher(name:'9', description: 'seaef', liked: false),
      Teacher(name:'10', description:  'seffe', liked: true),
      Teacher(name:'11', description:  'saeffe', liked: false),
      Teacher(name:'12', description: 'afe', liked: true),
      Teacher(name:'13', description: 'seaef', liked: false),
      Teacher(name:'14', description:  'see', liked: true),
      Teacher(name:'15', description:  'saeffe', liked: false),
      Teacher(name:'16', description:  'xxx', liked: false),
    ];
    await new Future.delayed(const Duration(seconds : 1));
    print(startIndex);
    print(startIndex + limit);
    if (startIndex + limit > 16) {
      return teachersList.sublist(startIndex, 16);
    } else {
      return teachersList.sublist(startIndex, startIndex + limit);
    }
  }

  _fetchPostsB(int startIndex, int limit) async {
    final List<Teacher> teachersList = [
      Teacher(name:'um', description:'hi', liked: true),
      Teacher(name:'dos', description: 'hiiii', liked: false),
      Teacher(name:'tres', description: 'hihihi', liked: true),
      Teacher(name:'quatro', description: 'hihi', liked: true),
      Teacher(name:'cinco', description: 'hiiiii', liked: false),
      Teacher(name:'seis', description: 'hiiih', liked: false),
      Teacher(name:'sete', description: 'mu', liked: true),
      Teacher(name:'oito', description: 'afe', liked: true),
      Teacher(name:'nove', description: 'seaef', liked: false),
      Teacher(name:'dez', description:  'seffe', liked: true),
      Teacher(name:'onze', description:  'saeffe', liked: false),
      Teacher(name:'doze', description: 'afe', liked: true),
      Teacher(name:'treze', description: 'seaef', liked: false),
      Teacher(name:'quatorze', description:  'see', liked: true),
      Teacher(name:'quize', description:  'saeffe', liked: false),
      Teacher(name:'dezesseis', description:  'xxx', liked: false),
      Teacher(name:'dezessete', description:  'xxx', liked: true),
      Teacher(name:'dezoito', description:  'xxx', liked: false),
      Teacher(name:'dezenove', description:  'xxx', liked: false),
      Teacher(name:'vinte', description:  'xxx', liked: false),
    ];
    await new Future.delayed(const Duration(seconds : 1));
    print(startIndex);
    print(startIndex + limit);
    if (startIndex + limit > 20) {
      return teachersList.sublist(startIndex, 20);
    } else {
      return teachersList.sublist(startIndex, startIndex + limit);
    }
  }

}
