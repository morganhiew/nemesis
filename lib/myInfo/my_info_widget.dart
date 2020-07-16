import 'package:flutter/material.dart';

// Define a custom Form widget.
class MyInfoWidget extends StatefulWidget {
  @override
  MyInfoWidgetState createState() {
    return MyInfoWidgetState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyInfoWidgetState extends State<MyInfoWidget> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final savedName = "Adam smith";
  final savedTel = "28899933";
  final savedAddress = "Broadcast road";

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Add TextFormFields and RaisedButton here.
              SizedBox(height: 15,),
              RichText(
                text: TextSpan(
                  text: '更新你的個人資訊',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                initialValue: savedName,
                decoration: InputDecoration(
                  hintText: "顯示名",
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
                  return null;
                },
              ),
              SizedBox(height: 15,),
              TextFormField(
                initialValue: savedTel,
                decoration: InputDecoration(
                  hintText: "電話",
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
                  return null;
                },
              ),
              SizedBox(height: 15,),
              TextFormField(
                initialValue: savedAddress,
                decoration: InputDecoration(
                  hintText: "地址",
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
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('Processing Data')));
                      }
                    },
                    child: Text('更新'),
                  ),
                  SizedBox(width: 50,),
                  RaisedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('Processing Data')));
                      }
                    },
                    child: Text('取消'),
                  ),
                ],
              )

    ]
        )
    );
  }
}
