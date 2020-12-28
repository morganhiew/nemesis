import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 200,),
            Center(
              child: RaisedButton.icon (
                color: Colors.grey,
                key: const Key('homePage_logout_iconButton'),
                label: const Text(
                      'ログアウト',
                      style: TextStyle(color: Colors.white),
                    ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                icon: const Icon(FontAwesomeIcons.signOutAlt, color: Colors.white),
                onPressed: () => authenticationRepository.logOut(),
              ),
            ),
          ],
            // RaisedButton.icon(
            //   key: const Key('loginForm_googleLogin_raisedButton'),
            //   label: const Text(
            //     'グーグルで登録',
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            //   icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
            //   color: theme.accentColor,
            //   onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
            // );

        )
    );
  }


}
