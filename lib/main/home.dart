import 'package:flutter/material.dart';
import 'package:myclinic/main/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyClinic',
      theme: ThemeData(primarySwatch: Colors.blueGrey, fontFamily: 'OpenSans'),
      onGenerateRoute: RouterClass.generateRoute,
      initialRoute: 'login',
    );
  }
}


