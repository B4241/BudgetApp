import 'package:brew/Authentic/Signin.dart';
import 'package:brew/Authentic/r.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  @override
  State<Auth> createState() => _Auth();
}

class _Auth extends State<Auth> {
  num S = 1;
  void toggleview() {
    setState(() {
      if (S == 1) {
        S = 0;
      } else {
        S = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (S == 1) {
      return SignIn(tv: toggleview);
    } else {
      return Register(tv: toggleview);
    }
  }
}
