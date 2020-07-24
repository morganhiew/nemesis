import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemesis/teacherFilter/filterTeacherBloc.dart';
import 'package:nemesis/teacherList/teacherListBloc.dart';
import 'package:nemesis/teacherList/teacherListEvent.dart';
import 'package:nemesis/teacherList/teacherListWidget.dart';

import '../teacherFilter/filterTeacherWidget.dart';

class TeacherListWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final teacherBloc = TeacherBloc();
    return BlocProvider<TeacherBloc>(
      create: (context) => TeacherBloc()..add(TeacherFetched()),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: FilterTeacherWidget(context)
            ),
            Expanded(
              child: TeacherListWidget(context)
                ),
          ],
        ),
      ),

    );
//    Container(
//      child: Column(
//        children: <Widget>[
//          Container(
//            child:
//              BlocProvider<FilterTeacherBloc>(
//                create: (context) =>
//                FilterTeacherBloc(),
//                child: FilterTeacherWidget(),
//              ),
//          ),
//          Expanded(
//            child:
//              BlocProvider<TeacherBloc>(
//                create: (context) =>
//                TeacherBloc()..add(TeacherFetched()),
//                child: TeacherListWidget(),
//              ),
//          )
//        ],
//      ),
//    );
  }
}