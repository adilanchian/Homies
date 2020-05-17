import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../styles.dart';

import 'homiesRegisterPage.dart';

// Will probably want to have a widget with a state
class HomiesSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.baseBGColor,
      child: SafeArea(
        child: SignInContainer(),
      ),
    );
  }
}

class SignInContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15.0),
        color: Styles.baseBGColor,
        child: Column(
          children: <Widget>[
            SignInDetails(),
            Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: SignInActions())
          ],
        ));
  }
}

class SignInDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'Welcome Homies',
              style: Styles.headerTextStyle,
            )
          ],
        ),
        Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 15.0),
              child: Text(
                  'Homies is a cool way to  keep your homies in sync with your household needs.',
                  style: Styles.detailTextStyle),
            )
          ],
        )
      ],
    );
  }
}

class SignInActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 44.0,
          width: 180.0,
          child: OutlineButton(
            borderSide:
                BorderSide(color: Styles.buttonEnabledOutlineColor, width: 2.0),
            highlightedBorderColor: Styles.buttonHighlightedOutlineColor,
            child: Text('Sign In', style: Styles.buttonTitleStyle),
            onPressed: () => {_pushRegister(context)},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text('Need an account?', style: Styles.subtitleTextStyle)),
        FlatButton(
            child:
                Text('Get Started With Homies', style: Styles.actionTextStyle),
            onPressed: () => {print("HALLO")})
      ],
    );
  }
}

// Helpers
void _pushRegister(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute<Null>(
          builder: (BuildContext context) {
            return HomiesRegisterPage();
          },
          fullscreenDialog: true));
}
