import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/providers/todos_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddBottomSheet extends StatefulWidget {
  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  String title = "";
  String description = "";
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  late TodosProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      padding: EdgeInsetsDirectional.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsetsDirectional.all(40),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.newtask,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.headlineMedium,
                  validator: (text){
                    if(text==null || text.isEmpty){
                      return AppLocalizations.of(context)!.titleerror;
                    }
                  },
                  onChanged: (value){
                    title = value;
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.newtitle,
                    hintStyle: Theme.of(context).textTheme.bodySmall
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  style: Theme.of(context).textTheme.headlineMedium,
                  validator: (text){
                    if(text==null || text.isEmpty){
                      return AppLocalizations.of(context)!.descerror;
                    }
                  },
                  maxLines: 3,
                  onChanged: (value){
                    description = value;
                  },
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.newdesc,
                      hintStyle: Theme.of(context).textTheme.bodySmall
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  AppLocalizations.of(context)!.newtime,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    showBottomDatePicker();
                  },
                  child: Text(
                      DateFormat.yMMMd().format(provider.selectedDate).toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: (){
                      addTodo();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.add,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showBottomDatePicker(){
    showDatePicker(
      context:context,
      initialDate: provider.selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((selectedDate){
      provider.selectedDate = selectedDate??provider.selectedDate;
      setState((){});
    });
  }

  void addTodo() {
    if(formKey.currentState!.validate()){
      CollectionReference users = FirebaseFirestore.instance.collection('todos');
      users.doc().set(
          {
            "title":title,
            "description":description,
            "date_time":provider.selectedDate.millisecondsSinceEpoch,
            "checked":false
          }
      ).timeout(Duration(microseconds: 500),onTimeout: (){
        print("refreshAdd");
        provider.refreshTodos();
        Navigator.pop(context);
      });

    }
  }
}
