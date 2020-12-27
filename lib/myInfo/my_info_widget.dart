import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:nemesis/myInfo/my_info_cubit.dart';
import 'package:nemesis/myInfo/my_info_state.dart';

// Define a custom Form widget.
class MyInfoWidget extends StatefulWidget {
  final User user;

  const MyInfoWidget({Key key, this.user}) : super(key: key);

  @override
  _MyInfoWidget createState() {
    return _MyInfoWidget(user: user);
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class _MyInfoWidget extends State<MyInfoWidget> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final User user;
  final List<String> textFieldsValue = new List(3);
  final MyInfoCubit _myInfoCubit = MyInfoCubit();

  _MyInfoWidget({this.user});

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    FocusScopeNode currentFocus = FocusScope.of(context);
    return BlocListener(
      cubit: _myInfoCubit,
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('個人情報が更新されました')),
            );
        } else if (state.status == FormzStatus.submissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('更新失敗。もう一度やり直してください')),
            );
        }
      },
      child: BlocBuilder<MyInfoCubit, MyInfoState>(
        cubit: _myInfoCubit..getInfo(uid: user.id),
        // buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          print('rebuild');
          print(state.address);
          return Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Add TextFormFields and RaisedButton here.
                    SizedBox(height: 15,),
                    RichText(
                      text: TextSpan(
                        text: '個人情報',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      key: ObjectKey(state.nickname),
                      initialValue: state.nickname,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15.0),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text a';
                        }
                        textFieldsValue[0] = value;
                        return null;
                      },
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      key: ObjectKey(state.phone),
                      initialValue: state.phone,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15.0),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text a';
                        }
                        textFieldsValue[1] = value;
                        return null;
                      },
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      key: ObjectKey(state.address),
                      initialValue: state.address,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15.0),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text a';
                        }
                        textFieldsValue[2] = value;
                        return null;
                      },
                    ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false
                            // otherwise.
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a Snackbar.
                              print(textFieldsValue);
                              _myInfoCubit
                                  .updateInfo(uid: user.id, nickname: textFieldsValue[0], phone: textFieldsValue[1], address: textFieldsValue[2]);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            }
                          },
                          child: Text('更新'),
                        ),
                        SizedBox(width: 50,),
                        RaisedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false
                            // otherwise.
                            _myInfoCubit
                                .refresh();
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          },
                          child: Text('取消'),
                        ),
                      ],
                    )

                  ]
              )
          );
        },
      ),
    );
  }
}
