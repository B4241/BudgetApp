import 'package:brew/Authentic/Verificationbe.dart';
import 'package:flutter/material.dart';
import 'package:brew/Authentic/Signin.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('Brew for Now'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        actions: [
          ElevatedButton(
              onPressed: () async {
                await _auth.SignOut();
              },
              child: Row(
                children: [
                  Icon(Icons.person_2_outlined),
                  SizedBox(width: 10),
                  Text(
                    'Logout',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
