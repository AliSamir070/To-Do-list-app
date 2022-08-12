import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/providers/local_provider.dart';
import 'package:todo_list_app/providers/theme_provider.dart';
import 'package:todo_list_app/providers/todos_provider.dart';
import 'package:todo_list_app/ui.screens/home.dart';
import 'package:todo_list_app/ui.screens/update/update_screen.dart';
import 'package:todo_list_app/utills/AppStyle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  await FirebaseFirestore.instance.disableNetwork();

  runApp(ChangeNotifierProvider(
    create: (BuildContext context)=>TodosProvider(),
    child: ChangeNotifierProvider(
      create: (BuildContext context)=>LocalProvider(),
      child: ChangeNotifierProvider(
          create: (BuildContext context)=>ThemeProvider(),
          child: const MyApp()),
    ),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("build");
    ThemeProvider themeProvider = Provider.of(context);
    LocalProvider localProvider = Provider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Home.route:(_)=>Home(),
        UpdateScreen.route:(_)=>UpdateScreen()
      },
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('ar', ''), // Arabic, no country code
      ],
      initialRoute: Home.route,
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      themeMode: themeProvider.mode,
      locale: Locale(localProvider.locale),

    );
  }
}

