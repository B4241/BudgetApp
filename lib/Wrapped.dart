import 'package:brew/Authentic/Auth.dart';
import 'package:brew/Authentic/CustomUse.dart';
import 'package:brew/Authentic/Signin.dart';
import 'package:brew/Authentic/r.dart';
import 'package:brew/Authentic/Home2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Userstate = Provider.of<CustomUse?>(context);
    if (Userstate != null) {
      return House();
    } else {
      return Auth();
    }
  }
}
