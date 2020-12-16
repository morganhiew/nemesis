// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemesis/authentication/authentication_bloc.dart';
import 'package:nemesis/authentication/authentication_event.dart';
import 'package:nemesis/splash/splash_page.dart';
import 'package:nemesis/user/user_repository.dart';

import 'authentication/authentication_state.dart';
import 'home_widget.dart';
import 'login/login_screen.dart';
import 'loading/loading_indicator.dart';

void main() => runApp(
    MyApp()
);

class MyApp extends StatefulWidget {
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    print('init state');
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Georgia',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: BlocProvider(
        lazy: false,
        create: (BuildContext context) => AuthenticationBloc(userRepository: _userRepository),
        child: MaterialApp(
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            cubit: _authenticationBloc,
            // ignore: missing_return
            builder: (context, state) {
              print('hi'+ state.toString());
              if (state is Uninitialized) {
                return SplashPage();
              }
              if (state is Unauthenticated) {
                return LoginScreen(userRepository: _userRepository,);
              }
              if (state is Authenticated) {
                return Home();
              }
            },
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _authenticationBloc.dispose();
  //   super.dispose();
  // }
}
