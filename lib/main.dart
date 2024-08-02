import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_kearsipan/pages/about.dart';
import 'package:project_kearsipan/pages/contact.dart';
import 'package:project_kearsipan/pages/home.dart';
import 'package:project_kearsipan/pages/landing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kearsipan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/home': (context) => HomePage(),
        '/contact': (context) => ContactPage(),
        '/about': (context) => AboutPage(),
      },
    );
  }
}
