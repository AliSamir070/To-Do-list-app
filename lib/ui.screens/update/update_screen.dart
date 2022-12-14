import 'package:flutter/material.dart';
import 'package:todo_list_app/shared/components/components.dart';
import 'package:todo_list_app/ui.screens/add_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class UpdateScreen extends StatelessWidget {
  static String route = "update_screen";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  AppBar(
                    title: Text(AppLocalizations.of(context)!.todolist),
                    flexibleSpace: SizedBox(
                      height: height*.2,
                    ),
                    titleSpacing: width*0.1,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: width*0.06),
                      child: UpdateCard()
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
