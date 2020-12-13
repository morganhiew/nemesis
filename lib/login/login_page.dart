import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemesis/authentication/authentication_bloc.dart';
import 'login_bloc.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  // final UserRepository userRepository;
  //
  // login({Key key, @required this.userRepository})
  //     : assert(userRepository != null),
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login | Home Hub'),
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            BlocProvider.of<AuthenticationBloc>(context)
          );
        },
        child: LoginForm(),
      ),
    );
  }
}