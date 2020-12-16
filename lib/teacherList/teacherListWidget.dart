import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemesis/teacherList/teacherClass.dart';
import 'package:nemesis/teacherList/teacherBloc.dart';
import 'package:nemesis/teacherList/teacherEvent.dart';
import 'package:nemesis/teacherList/teacherState.dart';

// Define a custom Form widget.
Widget TeacherListWidget(context) {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  final _teacherBlocInstance = BlocProvider.of<TeacherBloc>(context);


  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _teacherBlocInstance.add(TeacherFetched());
    }
  }

  _scrollController.addListener(_onScroll);

  return Scaffold (
      body:
      BlocBuilder<TeacherBloc, TeacherState> (
        cubit: _teacherBlocInstance..add(TeacherFetched()),
        // ignore: missing_return
        builder: (context, state) {
          if (state is TeacherInitial) {
            print('REBUILD teacherListWidget A');
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TeacherFailure) {
            print('REBUILD teacherListWidget B');
            return Center(
              child: Text('failed to fetch teachers list'),
            );
          }
          if (state is TeacherSuccess) {
            print('REBUILD teacherListWidget C');
            if (state.teachers.isEmpty) {
              return Center(
                child: Text('no result'),
              );
            }
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: state.hasReachedMax
                  ? state.teachers.length
                  : state.teachers.length + 1,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                print('listview builder index: ' + index.toString());
                return index >= state.teachers.length && !state.hasReachedMax
                    ? BottomLoader()
                    : makeCard(teacher: state.teachers[index]);
              },
            );
          }
        },
      ),
    );
  }




makeCard({Teacher teacher}) {

  return Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(color: Colors.white30),
      child: makeListTile(teacher),
    ),
  );
}

makeListTile(Teacher teacher) {
  return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(Icons.person, color: Colors.black),
      ),
      title: Text(
        teacher.name,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
      subtitle: Row(
        children: <Widget>[
          Icon(Icons.linear_scale, color: Colors.yellowAccent),
          Text(teacher.description, style: TextStyle(color: Colors.black))
        ],
      ),
      trailing:
      Icon(Icons.favorite, color: (teacher.liked? Colors.red: Colors.grey), size: 30.0));
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}