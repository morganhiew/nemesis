import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'login_event.dart';
import 'login_state.dart';
import 'package:nemesis/authentication/authentication_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc(this.authenticationBloc) : super(null);

  // LoginBloc({
  //   @required this.userRepository,
  //   @required this.authenticationBloc,
  // })  : assert(userRepository != null),
  //       assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
      LoginEvent event,
      ) async* {
    if (event is LoginButtonPressed) {
      yield LoginInitial();

      // try {
      //   final user = await userRepository.authenticate(
      //     username: event.username,
      //     password: event.password,
      //   );
      //
      //   authenticationBloc.add(LoggedIn(user: user));
      //   yield LoginInitial();
      // } catch (error) {
      //   yield LoginFaliure(error: error.toString());
      }
    }
}
