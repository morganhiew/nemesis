import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemesis/register/register_form.dart';
import 'package:nemesis/user/user_repository.dart';
import 'package:nemesis/register/bloc.dart';

class RegisterScreen extends StatefulWidget {
  final UserRepository _userRepository;

  RegisterScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc(
      userRepository: widget._userRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          lazy: false,
          create: (BuildContext context) => RegisterBloc(userRepository: widget._userRepository),
          child: RegisterForm(),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _registerBloc.dispose();
  //   super.dispose();
  // }
}