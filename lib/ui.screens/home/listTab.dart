import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/shared/components/components.dart';
import 'package:todo_list_app/providers/todos_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/todo.dart';
import '../../providers/local_provider.dart';
import '../../providers/theme_provider.dart';

class ListTab extends StatefulWidget {

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late TodosProvider provider;
  late LocalProvider localProvider;
  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    localProvider = Provider.of(context);
    themeProvider = Provider.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(bottom: height*0.03),
                child: AppBar(
                  title: Text(AppLocalizations.of(context)!.todolist),
                  flexibleSpace: SizedBox(
                    height: height*.2,
                  ),
                    titleSpacing: width*0.1
                ),
              ),
              CalendarTimeline(
                initialDate: provider.selectedDate,
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now().add(Duration(days: 365)),
                onDateSelected: (time){
                  provider.setNewSelected(time);
                  print("selected");
                },
                showYears: false,
                dayColor: themeProvider.mode==ThemeMode.light?Colors.black:Colors.white,
                dayNameColor: themeProvider.mode==ThemeMode.light?Colors.black:Colors.white,
                monthColor: themeProvider.mode==ThemeMode.light?Colors.black:Colors.white,
                dotsColor: Theme.of(context).secondaryHeaderColor,
                activeDayColor: Theme.of(context).primaryColor,
                activeBackgroundDayColor: Theme.of(context).secondaryHeaderColor,
              )
            ],
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                    itemBuilder: (context , index)=>TodoItem(provider.todos[index]),
                    itemCount: provider.todos.length,
                ),
              )
          )
        ],
      ),
    );
  }

}
