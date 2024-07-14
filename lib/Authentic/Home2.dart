import 'package:flutter/material.dart';
import 'dart:async';
import 'Extrar.dart';
import 'package:brew/Authentic/Verificationbe.dart';
import 'Data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

int i = 0;
var UnivarsalCounter = 1;
StreamController<Entry> streamController = StreamController<Entry>.broadcast();
List<Entry> Entries = [];
void Fetchdoc() async {
  Entries.clear();
  i = 0;
  int j = 0;
  print(req);
  var uerRef =
      await FirebaseFirestore.instance.collection('Users').doc(req).get();
  String Q = uerRef.data().toString();
  int x = ','.allMatches('$Q').length;
  while (j < (x + 1) / 2) {
    var a = uerRef.data()?['name:$j'];
    var b = uerRef.data()?['amount:$j'];
    print(a);
    print(b);
    if (b != null) {
      Entry qwa = Entry(name: a, amount: b, number: i);
      Entries.add(qwa);

      Future.delayed(const Duration(milliseconds: 2000), () {});
      if (i == j) {
        j++;
        i++;
        continue;
      } else {
        Map<String, dynamic> dataToSave = {'name:$j': null, 'amount:$j': null};
        FirebaseFirestore.instance
            .collection('Users')
            .doc(req)
            .update(dataToSave);
        Future.delayed(const Duration(milliseconds: 2000), () {});
        Map<String, dynamic> datToSave = {
          'name:$i': '${qwa.name}',
          'amount:$i': qwa.amount
        };
        FirebaseFirestore.instance
            .collection('Users')
            .doc(req)
            .update(datToSave);
        i++;
      }
    }
    j++;
  }
}

num Total() {
  num T = 0;
  for (var i = 0; i < Entries.length; i++) {
    Entry temp = Entries[i];
    T = T + temp.amount;
  }
  return T;
}

class House extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HOME(),
        routes: <String, WidgetBuilder>{
          '/Expenses': (context) => Expenses(streamController.stream),
          '/New': (context) => New()
        });
  }
}

class HOME extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    print(Entries);
    return Scaffold(
        backgroundColor: Colors.purple[500],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.purple[300],
          title: Text('Budget Tracker',
              style: TextStyle(
                  color: Colors.purple[600], fontWeight: FontWeight.bold)),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ))
          ],
        ),
        body: Center(
            child: Column(children: [
          SizedBox(height: 100),
          Icon(Icons.account_circle_sharp, color: Colors.grey[900], size: 58),
          SizedBox(height: 20),
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.blue,
                child: Column(
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      'Back!',
                      style: TextStyle(fontSize: 25),
                    )
                  ],
                ),
              ) // Your widget that needs to be rounded.
              ),
          SizedBox(height: 80),
          Container(
            width: 320,
            height: 42,
            child: Row(children: [
              SizedBox(width: 10),
              Text(
                'Total:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 120),
              Text(
                'Click me',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 10),
              InkWell(
                  onTap: () {
                    print('Hi');
                    Navigator.pushNamed(context, '/Expenses');
                  },
                  child: Icon(Icons.expand_circle_down))
            ]),
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: StadiumBorder(
                  side: BorderSide(color: Colors.red, width: 2),
                )),
          )
        ])));
  }
}

void idk() {
  i = 0;
  Entries.clear();
  Entries.add(Entry(name: 'Sample', amount: 000));
  Map<String, dynamic> dataToSave = {'name:0': 'Sample', 'amount:0': 0};
  FirebaseFirestore.instance.collection('Users').doc(req).set(dataToSave);
}

class Expenses extends StatefulWidget {
  Expenses(this.stream);
  final Stream<Entry> stream;
  @override
  State<Expenses> createState() => ExpensesState();
}

class ExpensesState extends State<Expenses> {
  @override
  void initState() {
    super.initState();
    widget.stream.listen((entry) {
      if (UnivarsalCounter == 1) {
        delete(entry);
      } else {
        add(entry);
      }
    });
  }

  void delete(Entry entry) {
    setState(() {
      Entries.remove(entry);
    });
    Future.delayed(const Duration(milliseconds: 5000), () {});
    FirebaseFirestore.instance
        .collection('Users')
        .doc(req)
        .update({'name:${entry.number}': null, 'amount:${entry.number}': null});
  }

  void add(Entry entry) {
    setState(() {
      Entries.add(entry);
    });
    Future.delayed(const Duration(milliseconds: 5000), () {});
    Map<String, dynamic> dataToSave = {
      'name:${entry.number}': '${entry.name}',
      'amount:${entry.number}': entry.amount
    };
    FirebaseFirestore.instance.collection('Users').doc(req).update(dataToSave);
    Future.delayed(const Duration(milliseconds: 10000), () {});
  }

  void Fetchdoc() async {
    List<Entry> qwa = [];
    var userRef = await FirebaseFirestore.instance
        .collection('Users')
        .doc(req)
        .get() as Map;
    num x = userRef.length;
    var lawn =
        await FirebaseFirestore.instance.collection('Users').doc(req).get();
    for (int j = 0; j < (x / 2); j++) {
      if (lawn.data()?['name:${j}'] != null) {
        Entry zig = Entry(
            name: lawn.data()?['name:${j}'],
            amount: lawn.data()?['amount:${i}'],
            number: i);
        Entries.add(zig);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        leading: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.purple[600],
                ))),
        centerTitle: true,
        backgroundColor: Colors.purple[300],
        title: Text('Budget Tracker',
            style: TextStyle(
                color: Colors.purple[600], fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            Column(children: [
              SizedBox(height: 50),
              Container(
                width: 320,
                height: 42,
                child: Row(children: [
                  SizedBox(width: 10),
                  Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 140),
                  Text(
                    '${Total()}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.expand_circle_down)
                ]),
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: StadiumBorder(
                      side: BorderSide(color: Colors.red, width: 2),
                    )),
              ),
              SizedBox(height: 80),
            ]),
            Column(children: Entries.map((entry) => lay(entry)).toList())
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.pushNamed(context, '/New');
          },
          child: Icon(Icons.add, color: Colors.yellow)),
    );
  }
}

class New extends StatelessWidget {
  TextEditingController orice1controller = new TextEditingController();
  TextEditingController categrol = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple,
        appBar: AppBar(
          leading: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.purple[600],
                  ))),
          centerTitle: true,
          backgroundColor: Colors.purple[300],
          title: Text('Budget Tracker',
              style: TextStyle(
                  color: Colors.purple[600], fontWeight: FontWeight.bold)),
        ),
        body: Center(
          child: Container(
              height: 200,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New Entry',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 5),
                      Text(
                        'Price:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(width: 5),
                      Container(
                        height: 25,
                        width: 180,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 20.5,
                              fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          controller: orice1controller,
                          decoration: InputDecoration(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 5),
                      Text('Category:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      SizedBox(width: 5),
                      Container(
                        height: 25,
                        width: 140,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 20.5,
                              fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.text,
                          controller: categrol,
                          decoration: InputDecoration(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            late Entry eew = Entry(
                                name: categrol.text,
                                amount: int.parse(orice1controller.text),
                                number: i++);
                            UnivarsalCounter = 0;
                            streamController.add(eew);
                            categrol.text = "";
                            orice1controller.text = "";
                          },
                          child: Icon(Icons.check_circle_outline)),
                      SizedBox(width: 10)
                    ],
                  )
                ],
              )),
        ));
  }
}
