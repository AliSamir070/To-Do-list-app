import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/todo.dart';

class TodosProvider extends ChangeNotifier{
  List<Todo> todos = [];
  DateTime selectedDate = DateTime.now();
  TodosProvider(){
    print("refresh");
    refreshTodos();
  }
  void setNewSelected(DateTime newDate){
    selectedDate = newDate;
    refreshTodos();
  }
  void refreshTodos() async{
    QuerySnapshot querySnapshot = await Todo.getCollectionRef().get();
    todos = querySnapshot.docs.map((document){
      Map doc = document.data() as Map;

      return Todo(
          id: document.id,
          title: doc["title"],
          description: doc["description"],
          dateTime: DateTime.fromMillisecondsSinceEpoch(doc["date_time"]),
          checked: doc["checked"]
      );
    }).toList();
    print("refresh");
    todos = todos.where((todo){
      if(todo.dateTime.day==selectedDate.day && todo.dateTime.month==selectedDate.month && todo.dateTime.year==selectedDate.year){
        return true;
      }
      return false;
    }).toList();
    todos.sort((Todo t1 ,Todo t2){
      return t1.dateTime.compareTo(t2.dateTime);
    });
    print(todos.length);
    notifyListeners();
  }
}