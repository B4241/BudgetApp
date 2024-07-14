import 'package:flutter/material.dart';
import 'Home2.dart';

class Entry {
  late var name;
  late var amount;
  late int? number;
  Entry({this.name, this.amount, this.number});
}

Widget lay(entr) {
  num x = 240 + 5 * (entr.name.length);
  if (x < 250) {
    x = 250;
  }
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: x.toDouble(),
            height: 36,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 10),
                  Text(
                    entr.name,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(width: 85),
                  Row(
                    children: [
                      Text(
                        '${entr.amount}',
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.expand_circle_down),
                      SizedBox(width: 5)
                    ],
                  ),
                ]),
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: StadiumBorder(
                  side: BorderSide(color: Colors.red, width: 2),
                )),
          ),
          SizedBox(width: 10),
          Container(
              padding: EdgeInsets.all(5),
              child: InkWell(
                  onTap: () {
                    UnivarsalCounter = 1;
                    streamController.add(entr);
                  },
                  child: Icon(Icons.delete)),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)))
        ],
      ),
      SizedBox(height: 40),
    ],
  );
}
