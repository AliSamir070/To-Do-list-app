import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode mode = ThemeMode.light;
  SharedPreferences preferences;
  ThemeProvider(this.preferences){
    print("theme mode ref");
    getThemeFromPrefs();
  }
  void getThemeFromPrefs(){
    bool isDark = preferences.getBool('mode')??false;
    if(isDark){
      mode = ThemeMode.dark;
      print("notify mode");
    }else{
      mode = ThemeMode.light;
      print("notify mode");
    }
    notifyListeners();
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