import 'package:flutter/material.dart';
import 'package:price_cruncher_new/authentication/signIn.dart';
import 'package:price_cruncher_new/authentication/signUp.dart';

class Toggle extends StatefulWidget {
  // final String? from;
  const Toggle({
    Key? key,
    // this.id,
    // this.from,
  }) : super(key: key);

  @override
  _ToggleState createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  bool showSignIn = true;
  toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? SignIn(
            function: () {
              toggleView();
            },
          )
        : SignUp(
            function: () {
              toggleView();
            },
          );
  }
}
