import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SignIn(title: 'Sign In'),
    );
  }
}

class SignIn extends StatefulWidget {
  SignIn({Key key, this.title}) : super(key: key);

  // This widget is the SignIn page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignIn> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _signInForm = GlobalKey<FormState>();
  int _state = 0;
  RegExp emailRegex = new RegExp("[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+");

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(24.0),
        child: Form(
          key: _signInForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter email";
                  } else if (!emailRegex.hasMatch(value)) {
                    return "Please enter valid email.";
                  }
                },
                onSaved: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.0, style: BorderStyle.solid))),
              ),
              Container(
                margin: EdgeInsets.only(top: 16.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter password";
                    } else if (value.length < 6) {
                      return "Password must be 6 character long!";
                    }
                  },
                  onSaved: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.0, style: BorderStyle.solid))),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 36.0),
                child: new MaterialButton(
                  child: setupLoginButton(),
                  onPressed: () {
                    if (_signInForm.currentState.validate()) {
                      _signInForm.currentState.save();
                      final snackBar = SnackBar(
                          content: Text("Email: $email, Password: $password"),
                          action: SnackBarAction(
                            label: 'Done',
                            onPressed: () {
                              // Some code to undo the change!
                            },
                          ));
                      // Find the Scaffold in the Widget tree and use it to show a SnackBar!
                      _scaffold.currentState.showSnackBar(snackBar);
                      setState(() {
                        if (_state == 0) {
                          animateButton();
                        }
                      });
                    }
                  },
                  elevation: 4.0,
                  minWidth: double.infinity,
                  color: Colors.blueAccent,
                  height: 48.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget setupLoginButton() {
    if (_state == 0) {
      return new Text(
        "SignIn",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 2;
      });
    });
  }
}
