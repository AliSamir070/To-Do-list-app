import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/providers/local_provider.dart';
import 'package:todo_list_app/providers/theme_provider.dart';

import '../../utills/AppStyle.dart';
class SettingsTab extends StatelessWidget {
  late LocalProvider localProvider;
  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    localProvider = Provider.of(context);
    themeProvider = Provider.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppBar(
          title: Text(AppLocalizations.of(context)!.settings),
          flexibleSpace: SizedBox(
            height: height*.2,
          ),
          titleSpacing: width*0.1,
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                  AppLocalizations.of(context)!.language,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headlineMedium
              ),
              Spacer(),
              PopupMenuButton(
                color: Theme.of(context).secondaryHeaderColor,
                  icon: Icon(
                    Icons.more_vert_outlined,
                    color: themeProvider.mode==ThemeMode.light?Colors.black:Colors.white,
                  ),
                  itemBuilder: (context)=> [
                     PopupMenuItem(child: Text(
                        'English',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                       onTap: (){
                          localProvider.setLocale('en');
                       },
                     ),
                    PopupMenuItem(child: Text(
                      'العربية',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                      onTap: (){
                        localProvider.setLocale('ar');
                      },
                    ),
                  ]
              )
            ],
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.theme,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.start,
              ),
              Spacer(),
              Switch(
                  value: themeProvider.mode==ThemeMode.light?false:true,
                  onChanged: (value){
                    if(value){
                      themeProvider.setThemeMode(ThemeMode.dark);
                    }else{
                      themeProvider.setThemeMode(ThemeMode.light);
                    }
                  }
              )
            ],
          ),
        )
      ],
    );
  }
}
