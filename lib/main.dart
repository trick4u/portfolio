import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_cursor.dart';
import 'metafic_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tushar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: MetaficPage(),
    );
  }
}
