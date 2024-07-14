import 'dart:async';
import 'Verificationbe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'CustomUse.dart';
import 'r.dart';

class SignIn extends StatefulWidget {
  late Function? tv;

  SignIn({this.tv});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authobj = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String e = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[400],
      appBar: AppBar(
          backgroundColor: Colors.purple[900],
          elevation: 0.0,
          title: Text(
            'Sign into Budget Tracker',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  widget.tv!();
                },
                child: Row(
                  children: [
                    Icon(Icons.person_2_rounded),
                    Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ))
          ]),
      body: Center(
          child: Form(
        key: _formkey,
        child: Column(children: [
          SizedBox(height: 100),
          Container(
            width: 300,
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  )),
              validator: (val) => val!.isEmpty ? "Enter an email" : null,
              onChanged: (val) {
                email = val;
              },
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 300,
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  )),
              validator: (val) =>
                  val!.length < 6 ? "Enter a password 6+ chars long" : null,
              onChanged: (val) {
                password = val;
              },
              obscureText: true,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
                  UserCredential result =
                      await _authobj.SEmailpassword(email, password);
                  if (result == null) {
                    setState(() {
                      e = 'Could not Sign In';
                    });
                  }
                  shortUser?.uid = result.user?.uid;
                }
              },
              child: Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              )),
          SizedBox(height: 10),
          Text(e)
        ]),
      )),
    );
  }
}
