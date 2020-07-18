import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemesis/teacherFilter/filterTeacherEvent.dart';

import 'filterTeacherBloc.dart';
import 'filterTeacherState.dart';



class FilterTeacherWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FilterTeacherWidgetState();
}

class FilterTeacherWidgetState extends State<FilterTeacherWidget> {
  FilterTeacherBloc _filterTeacherBloc;

  void _showYearBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.music_note),
                    title: new Text('Music'),
                    onTap: () => {
                      setState(() =>
                          _filterTeacherBloc.add(
                            FilterTeacherButtonPressed(
                                FilterTeacherChip(label: 'musiclabel', description: 'hogehoge')
                            ),
                          )
                      )
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.videocam),
                    title: new Text('Video'),
                    onTap: () => {
                      _filterTeacherBloc.add(
                        FilterTeacherButtonPressed(
                            FilterTeacherChip(label: 'videolabel', description: 'fugafuga')
                        ),
                      )
                    }
                ),
              ],
            ),
          );
        }
    );
  }

  @override
  void initState() {
    super.initState();
    _filterTeacherBloc = BlocProvider.of<FilterTeacherBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            RaisedButton(
              child: Text("年級"),
              onPressed: (){
                  _showYearBottomSheet();
                },
            ),
            RaisedButton(
              child: Text("科目"),
              onPressed: (){
                //TODO
              },
            ),
            RaisedButton(
              child: Text("地區"),
              onPressed: (){
                //TODO
              },
            ),
          ],
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.greenAccent)
          ),
          child:
            BlocBuilder<FilterTeacherBloc, FilterTeacherState>(
              builder: (context, state) {
                if (state is FilterTeacherAdded) {
                  print('REBUILD');
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.filterTeacherChips.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 30,
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(state.filterTeacherChips[index].label, textAlign: TextAlign.center,),
                        ),
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
}
