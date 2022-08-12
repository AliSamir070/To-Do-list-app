import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProvider extends ChangeNotifier{
  String locale = "en";
  SharedPreferences preferences;
  LocalProvider(this.preferences){
    print("locale mode ref");
    getLocaleFromPrefs();
  }
  void getLocaleFromPrefs(){
    locale = preferences.getString('locale')??"en";
    print("notify locale");
    notifyListeners();
  }
  void UpdateLocaleToPrefs(String newLocale){
    SharedPreferences.getInstance().then((value){
      value.setString('locale', newLocale);
    });
  }
  void setLocale(String newLocale){
    if(locale != newLocale){
      locale = newLocale;
      UpdateLocaleToPrefs(newLocale);
      notifyListeners();
    }
  }
}