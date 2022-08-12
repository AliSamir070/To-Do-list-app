import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode mode = ThemeMode.light;
  ThemeProvider(){
    getThemeFromPrefs();
  }
  void getThemeFromPrefs(){
    SharedPreferences.getInstance().then((value){
      bool isDark = value.getBool('mode')??false;
      if(isDark){
        mode = ThemeMode.dark;
        print("notify");
      }else{
        mode = ThemeMode.light;
        print("notify");
      }
      notifyListeners();
    });
  }
  void UpdateThemeToPrefs(bool isDark){
    SharedPreferences.getInstance().then((value){
      value.setBool('mode', isDark);
    });
  }
  void setThemeMode(ThemeMode newMode){
    if(mode != newMode){
      mode = newMode;
      mode==ThemeMode.dark?UpdateThemeToPrefs(true):UpdateThemeToPrefs(false);
      notifyListeners();
    }
  }
}