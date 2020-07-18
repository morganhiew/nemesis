import 'package:bloc/bloc.dart';
import 'package:nemesis/teacherList/teacherClass.dart';
import 'package:nemesis/teacherList/teacherListEvent.dart';
import 'package:nemesis/teacherList/teacherListState.dart';


class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {

  TeacherBloc() : super(TeacherInitial());

  @override
  Stream<TeacherState> mapEventToState(TeacherEvent event) async* {
    final currentState = state;
    if (event is TeacherFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is TeacherInitial) {
          final teachers = _fetchPosts(0, 6);
          yield TeacherSuccess(teachers: teachers, hasReachedMax: false);
          return;
        }
        if (currentState is TeacherSuccess) {
          final posts =
          _fetchPosts(currentState.teachers.length, 6);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : TeacherSuccess(
            teachers: currentState.teachers + posts,
            hasReachedMax: false,
          );
        }
      } catch (_) {
        yield TeacherFailure();
      }
    }
  }

  bool _hasReachedMax(TeacherState state) =>
      state is TeacherSuccess && state.hasReachedMax;

  _fetchPosts(int startIndex, int limit) {
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
    print(startIndex);
    print(startIndex + limit);
    if (startIndex + limit > 15) {
      return teachersList.sublist(startIndex, 15);
    } else {
      return teachersList.sublist(startIndex, startIndex + limit);
    }
  }



}