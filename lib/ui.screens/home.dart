import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list_app/ui.screens/add_bottom_sheet.dart';
import 'package:todo_list_app/ui.screens/home/listTab.dart';

import 'home/settingsTab.dart';

class Home extends StatefulWidget {
  static String route = 'Home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int curentIndex =0;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> screens = [ListTab() , SettingsTab()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(

          onPressed: (){
            showTodoBottomSheet();
          },

          shape: StadiumBorder(
              side: BorderSide(
                  color: Colors.white,
                  width: 4
              )
          ),
          child: Icon(Icons.add),
        ),

        bottomNavigationBar: BottomAppBar(
          notchMargin: 16,
          shape: CircularNotchedRectangle(),
          clipBehavior: Clip.hardEdge,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index){
              curentIndex = index;
              setState((){});
            },
            currentIndex: curentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list) , label: 'list'),
              BottomNavigationBarItem(icon: Icon(Icons.settings) , label: 'settings'),
            ],
          ),
        ),
        body: screens[curentIndex],
      ),
    );
  }

  void showTodoBottomSheet() {
    /*scaffoldKey.currentState!.showBottomSheet(
          (context) => AddBottomSheet(),


    );*/
    showModalBottomSheet(
        context: context,
        builder: (context)=> AddBottomSheet(),
        isScrollControlled: true
    );
  }
}
