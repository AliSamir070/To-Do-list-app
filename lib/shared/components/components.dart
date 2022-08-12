import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/ui.screens/update/update_screen.dart';
import 'package:todo_list_app/utills/AppStyle.dart';

import '../../model/todo.dart';
import 'package:intl/intl.dart';

import '../../providers/local_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/todos_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TodoItem extends StatelessWidget {
  Todo todo;
  late TodosProvider provider;
  TodoItem(this.todo);
  late LocalProvider localProvider;
  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    localProvider = Provider.of(context);
    themeProvider = Provider.of(context);
    double height = MediaQuery.of(context).size.height;
    provider = Provider.of(context);
    return Slidable(
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),
        extentRatio: 0.21,
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context){
              Todo.getCollectionRef().doc(todo.id).delete().timeout(Duration(milliseconds: 500),onTimeout: (){
                provider.refreshTodos();
              });
            },
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12) , bottomLeft: Radius.circular(12)),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            autoClose: true,
          ),
        ],
      ),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, UpdateScreen.route , arguments: todo);
        },
        child: Container(
          margin: EdgeInsetsDirectional.only(bottom: 10),
          padding: EdgeInsets.symmetric(vertical: 8 , horizontal: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: height*0.07,
                color: todo.checked?AppStyle.checkedColor:Theme.of(context).primaryColor,
                width: 2,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      todo.title,
                      style: todo.checked?Theme.of(context).textTheme.displayLarge:Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 6,),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          size: 16,
                          color: themeProvider.mode==ThemeMode.light?Colors.black:Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          DateFormat.yMMMd().format(todo.dateTime),
                          style: Theme.of(context).textTheme.displaySmall,
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              todo.checked?Text(
                AppLocalizations.of(context)!.done,
                style: Theme.of(context).textTheme.headlineLarge,
              ):ElevatedButton(
                  onPressed: (){
                    Todo.getCollectionRef().doc(todo.id).update(
                      {
                        "checked":true
                      }
                    ).timeout(Duration(milliseconds: 500),onTimeout: (){
                      provider.refreshTodos();
                    });
                  },
                  child: Icon(
                    Icons.check
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
class UpdateCard extends StatefulWidget {

  @override
  State<UpdateCard> createState() => _UpdateCardState();
}

class _UpdateCardState extends State<UpdateCard> {
  var formKey = GlobalKey<FormState>();
  late Todo todo;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TodosProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    todo = ModalRoute.of(context)!.settings.arguments as Todo;
    titleController = TextEditingController(text: todo.title);
    descriptionController = TextEditingController(text: todo.description);
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsetsDirectional.only(top: height*0.12),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsetsDirectional.all(40),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Edit Task',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: titleController,

              validator: (text){
                if(text==null || text.isEmpty){
                  return "Title shouldn't be empty";
                }
              },
              style: Theme.of(context).textTheme.headlineMedium,
              decoration: InputDecoration(
                  hintText: "Please enter todo title",
                  hintStyle: Theme.of(context).textTheme.bodySmall,

              ),
              onChanged: (value){
                todo.title = value;
              },
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: descriptionController,
              onChanged: (value){
                todo.description = value;
              },
              style: Theme.of(context).textTheme.headlineMedium,
              validator: (text){
                if(text==null || text.isEmpty){
                  return "Description shouldn't be empty";
                }
              },
              maxLines: 3,

              decoration: InputDecoration(
                  hintText: "Please enter todo description",
                  hintStyle: Theme.of(context).textTheme.bodySmall
              ),
            ),
            SizedBox(height: 20,),
            Text(
              'Select Time',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                showBottomDatePicker();
              },
              child: Text(
                DateFormat.yMMMd().format(todo.dateTime).toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            SizedBox(height: height*0.1,),
            ElevatedButton(
                onPressed: (){
                  if(formKey.currentState!.validate()){
                    Todo.getCollectionRef().doc(todo.id).update(
                      {
                        "id":todo.id,
                        "title":todo.title,
                        "description":todo.description,
                        "checked":todo.checked,
                        "date_time":todo.dateTime.millisecondsSinceEpoch
                      }
                    ).timeout(Duration(milliseconds: 500),onTimeout: (){
                      provider.refreshTodos();
                      Fluttertoast.showToast(
                          msg: "Todo Updated Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Theme.of(context).primaryColor,
                          textColor: Theme.of(context).secondaryHeaderColor,
                          fontSize: 16.0
                      );
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text(
                  'Save changes',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
            ),
            SizedBox(height: height*0.1,),
          ],
        ),
      ),
    );
  }

  void showBottomDatePicker(){
    showDatePicker(
      context:context,
      initialDate: todo.dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((selectedDate){
      todo.dateTime = selectedDate??todo.dateTime;
      setState((){});
    });
  }
}

