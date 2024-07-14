import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'CustomUse.dart';
import 'Data.dart';
import 'Extrar.dart';
import 'Home2.dart';

CustomUse? shortUser;
String req = '';

class AuthService {
  List<Entry> initentry = [];
  final FirebaseAuth _Veri = FirebaseAuth.instance;

  CustomUse? userFromFirebaseUser(User? user) {
    return user != null ? CustomUse(uid: user.uid) : null;
  }

  Stream<CustomUse?> get StateChanges {
    return _Veri.authStateChanges()
        .map((User? user) => userFromFirebaseUser(user));
  }

  Future signinAno() async {
    try {
      UserCredential result = await _Veri.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  Future SEmailpassword(String Email, String Password) async {
    try {
      UserCredential Result = await _Veri.signInWithEmailAndPassword(
          email: Email, password: Password);
      User? user = Result.user;

      req = user!.uid;
      print('Now starting');
      Fetchdoc();
      return shortUser;
    } catch (e) {
      return null;
    }
  }

  Future REmailpassword(String Email, String Password) async {
    try {
      UserCredential Result = await _Veri.createUserWithEmailAndPassword(
          email: Email, password: Password);
      User? user = Result.user;

      await Dataprime(uid: user?.uid).updateUserData(initentry);

      req = user!.uid;
      idk();
      return shortUser;
    } catch (e) {
      return null;
    }
  }

  Future SignOut() async {
    try {
      return await _Veri.signOut();
    } catch (e) {
      return await null;
    }
  }
}
