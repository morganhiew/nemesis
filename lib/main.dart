// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'file:///C:/Users/morga/AndroidStudioProjects/nemesis/lib/authentication/bloc/authentication_bloc.dart';
import 'package:nemesis/simple_bloc_observer.dart';
import 'package:nemesis/splash/splash.dart';

import 'package:authentication_repository/authentication_repository.dart';
import 'home_widget.dart';
import 'login/view/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(authenticationRepository: AuthenticationRepository()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
    @required this.authenticationRepository,
}) : assert(authenticationRepository != null),
  super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        lazy: false,
        create: (context) => AuthenticationBloc(authenticationRepository: authenticationRepository),
        child: AppView(authenticationRepository: authenticationRepository)
      ),
    );
  }
}

class AppView extends StatefulWidget {

  final AuthenticationRepository authenticationRepository;

  const AppView({Key key, this.authenticationRepository}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState(authenticationRepository);
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final AuthenticationRepository authenticationRepository;

  _AppViewState(this.authenticationRepository);

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: theme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  MaterialPageRoute<void>(builder: (context) => HomePage(user: state.user, authenticationRepository: authenticationRepository)),
                      (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                      (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
