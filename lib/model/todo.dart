import 'package:cloud_firestore/cloud_firestore.dart';

class Todo{
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool checked;
  Todo({required this.id,required this.title,required this.description,required this.dateTime,required this.checked});

  static CollectionReference getCollectionRef(){
    return FirebaseFirestore.instance.collection("todos");
  }
}