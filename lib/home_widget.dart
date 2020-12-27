import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemesis/myInfo/my_info_widget.dart';
import 'package:nemesis/placeholder_widget.dart';
import 'package:nemesis/settings/settings_widget.dart';
import 'package:nemesis/teacherList/teacherBloc.dart';
import 'package:nemesis/teacherList/teacherListPage.dart';

import 'authentication/bloc/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  final User user;
  final AuthenticationRepository authenticationRepository;
  const HomePage({Key key, this.user, this.authenticationRepository}) : super(key: key);


  static Route route(user) {
    return MaterialPageRoute<void>(builder: (_) => HomePage(user: user));
  }

  @override
  Widget build(BuildContext context) {

    print('testing' + authenticationRepository.toString());
    // final textTheme = Theme.of(context).textTheme;
    // final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Home(user: user, authenticationRepository: authenticationRepository);
  }
}

class Home extends StatefulWidget {
  final User user;
  final AuthenticationRepository authenticationRepository;
  const Home({Key key, this.user, this.authenticationRepository}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _HomeState(user: user, authenticationRepository: authenticationRepository);
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 2;
  PageController _pageController;
  final User user;
  final AuthenticationRepository authenticationRepository;
  _HomeState({this.user, this.authenticationRepository});

  List<Widget> _children = [
    MyInfoWidget(),
    PlaceholderWidget(Colors.black),
    TeacherListWrapper(),
    PlaceholderWidget(Colors.transparent),
    PlaceholderWidget(Colors.blue),
    PlaceholderWidget(Colors.green)
  ];


  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 2);
    _children[0] = MyInfoWidget(user: user);
    _children[5] = SettingsWidget(authenticationRepository: authenticationRepository);
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
        resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('家庭教師マッチングアプリ', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
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
                title: new Text('個人情報'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.add_comment),
                title: new Text('検索条件'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.search),
                title: new Text('教師検索'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.favorite),
                title: new Text('気に入り'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.compare_arrows),
                title: new Text('マッチング'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  title: Text('設定')
              )
            ],
          ),
        ),
      ),
    );
  }

}
