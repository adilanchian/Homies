import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homies/firestore/firestoreActions.dart';

import 'package:homies/models/user.dart';
import '../styles.dart';

class HomiesRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Styles.baseBGColor,
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FlatButton(
                  child: Text('Close', style: Styles.actionTextStyle),
                  onPressed: () => {Navigator.pop(context)}),
            ],
          ),
          RegisterContainer(),
        ]));
  }
}

class RegisterContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            RegisterDetails(),
            RegisterInputForm(),
          ],
        ));
  }
}

class RegisterDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Wrap(
          children: <Widget>[
            Text(
              'Sign Up With Your Email',
              style: Styles.headerTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 15.0),
              child: Text(
                  'Just add your email and a super, secret password, and we will do the rest 🤓',
                  style: Styles.detailTextStyle),
            )
          ],
        ),
      ],
    );
  }
}

class RegisterInputFormState extends State<RegisterInputForm> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreActions _firestoreActions =
      new FirestoreActions(Firestore.instance);
  TextEditingController _emailTextController;
  TextEditingController _passwordTextController;
  TextEditingController _usernameTextController;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _usernameTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              CupertinoTextField(
                controller: _usernameTextController,
                placeholder: 'Username',
                placeholderStyle: Styles.placeholderTextStyle,
                cursorColor: Styles.inputBorderColor,
                padding: const EdgeInsets.only(
                    top: 6, right: 6, left: 10, bottom: 6),
                style: Styles.textInputStyle,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Styles.inputBorderColor, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: CupertinoTextField(
                    controller: _emailTextController,
                    placeholder: 'Email',
                    placeholderStyle: Styles.placeholderTextStyle,
                    cursorColor: Styles.inputBorderColor,
                    padding: const EdgeInsets.only(
                        top: 6, right: 6, left: 10, bottom: 6),
                    style: Styles.textInputStyle,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Styles.inputBorderColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: CupertinoTextField(
                      controller: _passwordTextController,
                      obscureText: true,
                      placeholder: 'Password 🕵️‍♀️',
                      placeholderStyle: Styles.placeholderTextStyle,
                      cursorColor: Styles.inputBorderColor,
                      padding: const EdgeInsets.only(
                          top: 6, right: 6, left: 10, bottom: 6),
                      style: Styles.textInputStyle,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Styles.inputBorderColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
              Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: SizedBox(
                      height: 44.0,
                      width: 180.0,
                      child: OutlineButton(
                        borderSide: BorderSide(
                            color: Styles.buttonEnabledOutlineColor,
                            width: 2.0),
                        highlightedBorderColor:
                            Styles.buttonHighlightedOutlineColor,
                        child: Text('Create', style: Styles.buttonTitleStyle),
                        onPressed: () async {
                          final shouldNavigate = await _onRegisterPressed(
                            this._auth,
                            this._firestoreActions,
                            this._emailTextController,
                            this._passwordTextController,
                            this._usernameTextController,
                          );

                          if (shouldNavigate) {
                            // Navigate away
                            Navigator.pop(context);
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Hmm... Looks like something went wrong 😅. Please try again.",
                                timeInSecForIosWeb: 4,
                                backgroundColor: Color(0xFF99E1D9),
                                textColor: Color(0xFF000000),
                                gravity: ToastGravity.BOTTOM);
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      )))
            ])));
  }
}

class RegisterInputForm extends StatefulWidget {
  @override
  RegisterInputFormState createState() {
    return RegisterInputFormState();
  }
}

// Helpers
Future<bool> _onRegisterPressed(
    FirebaseAuth auth,
    FirestoreActions firestoreActions,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController usernameController) async {
  try {
    final userData = await _registerNewUser(
        auth, emailController.text, passwordController.text);

    // Create user
    final newUser =
        User(userData.uid, emailController.text, usernameController.text);

    // Clear
    // OnePocketPimp: Today Alec tried to clear the text before he used the text
    emailController.clear();
    passwordController.clear();
    usernameController.clear();

    // Write user to user collection
    firestoreActions.createUser(newUser);

    // TODO - Store in local storage at some point?

    return true;
  } catch (err) {
    print('Registration Error: $err');
    return false;
  }
}

Future<FirebaseUser> _registerNewUser(
    FirebaseAuth auth, String email, String password) async {
  final FirebaseUser user = (await auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  ))
      .user;
  return user;
}
