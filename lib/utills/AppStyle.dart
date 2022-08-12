import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppStyle{
  static Color lightPrimaryColor = Color(0xff5D9CEC);
  static Color lightAccentColor = Color(0xffDFECDB);
  static Color darkPrimaryColor = Color(0xff5D9CEC);
  static Color darkAccentColor = Color(0xff060E1E);
  static Color lightTextSmallColor = Color(0xffA9A9A9).withOpacity(0.6);
  static Color checkedColor = Color(0xff61E757);
  static ThemeData lightTheme = ThemeData(
    canvasColor: Colors.white,
    scaffoldBackgroundColor: lightAccentColor,
    appBarTheme: AppBarTheme(
      backgroundColor: lightPrimaryColor,
      systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: lightPrimaryColor
        ),
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),

    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: lightPrimaryColor,
        padding: EdgeInsetsDirectional.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        )
      )
    ),
    textTheme: TextTheme(
      displaySmall: TextStyle(
        fontSize: 12,
        color: Colors.black
      ),
      displayLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: checkedColor
      ),
      headlineLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: checkedColor
      ),
      bodyLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: lightPrimaryColor
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold
      ),
      bodySmall: TextStyle(
          color: lightTextSmallColor,
          fontSize: 18
      ),
      headlineMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20
      )
    ),
    primaryColor: lightPrimaryColor,
    secondaryHeaderColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightPrimaryColor
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: lightPrimaryColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
        unselectedItemColor: Colors.black
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: darkAccentColor,
    appBarTheme: AppBarTheme(
      backgroundColor: darkPrimaryColor,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: darkPrimaryColor
      ),
      titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),

    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: darkPrimaryColor,
            padding: EdgeInsetsDirectional.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            )
        )
    ),
    canvasColor: Color(0xff141922),
    textTheme: TextTheme(
        displaySmall: TextStyle(
            fontSize: 12,
            color: Colors.white
        ),
        displayLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: checkedColor
        ),
        headlineLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: checkedColor
        ),
        bodyLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: darkPrimaryColor
        ),
        bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold
        ),
        bodySmall: TextStyle(
            color: Colors.white,
            fontSize: 18
        ),
        headlineMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20
        )
    ),
    primaryColor: darkPrimaryColor,
    secondaryHeaderColor: Color(0xff141922),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkPrimaryColor
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: darkPrimaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.white
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
    ),
  );
}