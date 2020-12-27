import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:nemesis/myInfo/my_info_cubit.dart';
import 'package:nemesis/myInfo/my_info_state.dart';

// Define a custom Form widget.
class SettingsWidget extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;

  const SettingsWidget({Key key, this.authenticationRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
          key: const Key('homePage_logout_iconButton'),
          icon: const Icon(Icons.exit_to_app),
          onPressed: () => authenticationRepository.logOut(),
        )
    );
  }


}
