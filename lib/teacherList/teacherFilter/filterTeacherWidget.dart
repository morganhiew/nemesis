import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemesis/teacherList/teacherBloc.dart';
import 'package:nemesis/teacherList/teacherEvent.dart';
import 'package:nemesis/teacherList/teacherState.dart';

import '../filterTeacherChipClass.dart';

Widget FilterTeacherWidget(BuildContext context) {
  final _teacherBlocInstance = BlocProvider.of<TeacherBloc>(context);
  return Column(
    children: <Widget>[
      Row(
        children: <Widget>[
          RaisedButton(
            child: Text("学年"),
            onPressed: () {
              _showYearBottomSheet(context);
            },
          ),
          RaisedButton(
            child: Text("科目"),
            onPressed: () {
              _showSubjectBottomSheet(context);
            },
          ),
          // RaisedButton(
          //   child: Text("地區"),
          //   onPressed: () {
          //     _showAreaBottomSheet(context);
          //   },
          // ),
        ],
      ),
      Container(
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.greenAccent)
          ),
          child:
          BlocBuilder<TeacherBloc, TeacherState>(
            cubit: _teacherBlocInstance,
            builder: (context, state) {
              int _itemCount = state.filterTeacherChips != null ? state.filterTeacherChips.length : 0;
              print('_itemcount ' + _itemCount.toString());
              if (state is TeacherSuccess) {
                print('REBUILD');
                ScrollController jumpController = ScrollController();
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  jumpController.jumpTo(
                      jumpController.position.maxScrollExtent);
                });
                return ListView.builder(
                  controller: jumpController,
                  scrollDirection: Axis.horizontal,
                  itemCount: _itemCount,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: <Widget>[
                        Container(
                          height: 30,
                          width: 50,
                          margin: const EdgeInsets.all(5.0),
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20))
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(state.filterTeacherChips[index].label,
                              textAlign: TextAlign.center,),
                          ),
                        ),
                        Positioned(
                            top: 0.0,
                            right: 0.0,
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: FloatingActionButton(
                                child: Icon(
                                  Icons.close, color: Colors.black, size: 18,),
                                onPressed: () {
                                  // ignore: unnecessary_statements
                                  print('delete ' +
                                      state.filterTeacherChips[index].label);
                                  _teacherBlocInstance.add(
                                    FilterTeacherDeleteButtonPressed(
                                        FilterTeacherChip(label: state
                                            .filterTeacherChips[index].label)
                                    ),
                                  );
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80)),
                                backgroundColor: Colors.white,

                                mini: true,
                              ),
                            )
                        )
                      ],
                    );
                  },
                );
              }
              else {
                return Container();
              }
            },
          )


      )
    ],
  );
}


void _showYearBottomSheet(context){
  int selectedIndex = 0;

  const List<Text> educationLevel = [
    Text('小１'),
    Text('小２'),
    Text('小３'),
    Text('小４'),
    Text('小５'),
    Text('小６'),
    Text('中１'),
    Text('中２'),
    Text('中３'),
    Text('高１'),
    Text('高２'),
    Text('高３'),
  ] ;

  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container (
//          height: 350,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xff999999),
                      width: 0.0,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('キャンセル'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 5.0,
                      ),
                    ),
                    CupertinoButton(
                      child: Text('次へ'),
                      onPressed: () {
                        print(selectedIndex);
                        print(educationLevel[selectedIndex].data);
                        Navigator.of(context).pop();
                        BlocProvider.of<TeacherBloc>(context).add(
                            FilterTeacherAddButtonPressed(
                                FilterTeacherYearChip(year: selectedIndex + 1,label: educationLevel[selectedIndex].data,
                                    description: educationLevel[selectedIndex].data)
                            ),
                        );
                      },
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 5.0,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 300,
                child: CupertinoPicker(
                  onSelectedItemChanged: (value) {
                    selectedIndex = value;
                  },
                  itemExtent: 30,
                  children: educationLevel,
                ),
              )
            ],
          ),
        );
      }
  );
}

void _showSubjectBottomSheet(context){
  int selectedIndex = 0;

  const List<Text> subjects = [
    Text('m'),
    Text('eng'),
    Text('chi'),
    Text('ls'),
    Text('phy'),
    Text('chem'),
    Text('bio'),
    Text('jp'),
    Text('football'),
  ] ;

  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container (
//          height: 350,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xff999999),
                      width: 0.0,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('キャンセル'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 5.0,
                      ),
                    ),
                    CupertinoButton(
                      child: Text('次へ'),
                      onPressed: () {
                        print(selectedIndex);
                        print(subjects[selectedIndex].data);
                        Navigator.of(context).pop();
                        BlocProvider.of<TeacherBloc>(context).add(
                          FilterTeacherAddButtonPressed(
                              FilterTeacherChip(category: Category.subject,label: subjects[selectedIndex].data,
                                  description: subjects[selectedIndex].data)
                          ),
                        );
                      },
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 5.0,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 300,
                child: CupertinoPicker(
                  onSelectedItemChanged: (value) {
                    selectedIndex = value;
                  },
                  itemExtent: 30,
                  children: subjects,
                ),
              )
            ],
          ),
        );
      }
  );
}

void _showAreaBottomSheet(context){
  int selectedIndex;

  const List<Widget> educationLevel = [

  ] ;

  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container (
          height: 350,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xff999999),
                      width: 0.0,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {},
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 5.0,
                      ),
                    ),
                    CupertinoButton(
                      child: Text('Confirm'),
                      onPressed: () {
                        print(selectedIndex);
                        FilterTeacherAddButtonPressed(
                            FilterTeacherChip(category: Category.area ,label: 'musiclabel', description: 'hogehoge')
                        );
                      },
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 5.0,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 300,
                child: CupertinoPicker(
                  onSelectedItemChanged: (value) {
                    selectedIndex = value;
                  },
                  itemExtent: 30,
                  children: educationLevel,
                ),
              )
            ],
          ),
        );
      }
  );
}