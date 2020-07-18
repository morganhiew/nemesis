import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemesis/myInfo/my_info_widget.dart';
import 'package:nemesis/placeholder_widget.dart';
import 'package:nemesis/teacherList/teacherListBloc.dart';
import 'package:nemesis/teacherList/teacherListPage.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  PageController _pageController;

  final List<Widget> _children = [
    MyInfoWidget(),
    PlaceholderWidget(Colors.black),
    TeacherListWrapper(),
    PlaceholderWidget(Colors.transparent),
    PlaceholderWidget(Colors.blue),
    PlaceholderWidget(Colors.green),
    PlaceholderWidget(Colors.red),
  ];



  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TeacherBloc>(
          create: (context) => TeacherBloc(),
        )
      ],
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/white.jpg"),
            fit: BoxFit.cover,
          ),
        ), child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('PP Tutor', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
                      backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SizedBox.expand(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: _children,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: onTabTapped,
            currentIndex: _currentIndex, // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.person),
                title: new Text('個人資訊'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.add_comment),
                title: new Text('我的條件'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.search),
                title: new Text('導師搜尋'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.favorite),
                title: new Text('已關注導師'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.compare_arrows),
                title: new Text('導師配對'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  title: Text('設定')
              )
            ],
          ),
        ),
      ),
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('PP Tutor', style: TextStyle(color: Colors.black),),
//          centerTitle: true,
//          backgroundColor: Colors.orangeAccent,
//          elevation: 0,
//        ),
//        body: SizedBox.expand(
//          child: PageView(
//            controller: _pageController,
//            onPageChanged: (index) {
//              setState(() => _currentIndex = index);
//            },
//            children: _children,
//          ),
//        ),
//        bottomNavigationBar: BottomNavigationBar(
//          type: BottomNavigationBarType.fixed,
//          onTap: onTabTapped,
//          currentIndex: _currentIndex, // this will be set when a new tab is tapped
//          items: [
//            BottomNavigationBarItem(
//              icon: new Icon(Icons.person),
//              title: new Text('個人資訊'),
//            ),
//            BottomNavigationBarItem(
//              icon: new Icon(Icons.add_comment),
//              title: new Text('我的條件'),
//            ),
//            BottomNavigationBarItem(
//              icon: new Icon(Icons.search),
//              title: new Text('導師搜尋'),
//            ),
//            BottomNavigationBarItem(
//              icon: new Icon(Icons.favorite),
//              title: new Text('已關注導師'),
//            ),
//            BottomNavigationBarItem(
//              icon: new Icon(Icons.compare_arrows),
//              title: new Text('導師配對'),
//            ),
//            BottomNavigationBarItem(
//                icon: Icon(Icons.settings),
//                title: Text('設定')
//            )
//          ],
//        ),
//      );

    );
  }

}

//class CustomShapeBorder extends ContinuousRectangleBorder {
//  @override
//  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
//
//    final double innerCircleRadius = 150.0;
//
//    Path path = Path();
//    path.lineTo(0, rect.height);
//    path.cubicTo(
//        rect.width / 1.5 - 40, rect.height + innerCircleRadius - 150,
//        rect.width / 1.5 + 40, rect.height + innerCircleRadius - 150,
//        rect.width / 1.5 + 75, rect.height + 50
//    );
//    path.quadraticBezierTo(rect.width / 1.5 + (innerCircleRadius / 2) + 30, rect.height + 35, rect.width, rect.height);
//    path.lineTo(rect.width, 0.0);
//    path.close();
//
//    return path;
//  }
//}