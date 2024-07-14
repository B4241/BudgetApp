import 'package:cloud_firestore/cloud_firestore.dart';
import 'Extrar.dart';

class Dataprime {
  String? uid;
  final CollectionReference Fire_base = FirebaseFirestore.instance.collection('Users');
  Dataprime({this.uid});

  Future? updateUserData(List<Entry> Entries) async{
    return await Fire_base.doc(uid).set({'name': '', 'amount': ''});
  }

  //collection reference
  final CollectionReference Fire_Base =
  FirebaseFirestore.instance.collection('Users');
}
List <num> sendprices(List<Entry> Entries) {
  List<num> Prices = [0];
  for (int i = 0; i < Entries.length; i++) {
    Prices[i] = Entries[i].amount;
  }
  return Prices;
}

List <String> sendNames(List<Entry> Entries){
  List<String> Names = [''];
  for (int i = 0; i < Entries.length; i++) {
    Names[i] = Entries[i].name;
  }
  return Names;
}
