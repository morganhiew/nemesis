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
import 'login/login_page.dart';
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

  // @override
  // void initState() {
  //   super.initState();
  //   print('init state');
  //   _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
  //   _authenticationBloc.add(AppStarted());
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => AuthenticationBloc(userRepository: _userRepository)..add(AppStarted()),
      child: MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          // bloc: _authenticationBloc,
          builder: (context, state) {
            print('hi'+ state.toString());
            if (state is Uninitialized) {
              return SplashPage();
            }
            return Container();
          },
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
