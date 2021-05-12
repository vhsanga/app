import 'package:flutter/material.dart';

// screens
import 'package:app/screens/onboarding.dart';
import 'package:app/screens/pro.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/profile.dart';
import 'package:app/screens/register.dart';
import 'package:app/screens/articles.dart';
import 'package:app/screens/elements.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Argon PRO Flutter',
        theme: ThemeData(fontFamily: 'OpenSans'),
        initialRoute: "/onboarding",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/onboarding": (BuildContext context) => new Onboarding(),
          "/home": (BuildContext context) => new Home(),
          "/profile": (BuildContext context) => new Profile(),
          "/articles": (BuildContext context) => new Articles(),
          "/elements": (BuildContext context) => new Elements(),
          "/account": (BuildContext context) => new Register(),
          "/pro": (BuildContext context) => new Pro(),
        });
  }
}
