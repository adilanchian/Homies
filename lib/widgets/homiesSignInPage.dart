import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homies/firestore/firestoreActions.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles.dart';
import 'homiesListPage.dart';

class HomiesSignInPage extends StatelessWidget {
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
        Text(
          'Sign In',
          style: Styles.headerTextStyle,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text('Already a Homie? Sign In below!',
              style: Styles.detailTextStyle),
        )
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

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
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
                        child: Text('Sign In', style: Styles.buttonTitleStyle),
                        onPressed: () async {
                          final canNavigate = await _onSignInPressed(
                            this._auth,
                            this._firestoreActions,
                            this._emailTextController,
                            this._passwordTextController,
                          );

                          if (canNavigate) {
                            // Navigate away
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute<Null>(
                                builder: (BuildContext context) {
                              return Container(
                                  color: Styles.baseBGColor,
                                  child: HomiesListPage());
                            }));
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Looks like there was an issue with your email or password! 😐",
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
Future<bool> _onSignInPressed(
  FirebaseAuth auth,
  FirestoreActions firestoreActions,
  TextEditingController emailController,
  TextEditingController passwordController,
) async {
  try {
    await auth.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);

    // Clear
    emailController.clear();
    passwordController.clear();

    return true;

    // TODO - Store in local storage at some point?
  } catch (err) {
    print('error $err');
    return false;
  }
}
