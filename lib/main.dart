import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_liveeasy/Pages/EnterMobileNoPage.dart';
import 'package:flutter_liveeasy/Pages/EnterOTPPage.dart';
import 'package:flutter_liveeasy/Pages/LanguageSelectionPage.dart';
import 'package:flutter_liveeasy/Pages/ProfileSelectionPage.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: ProfileSelection(),
    );
  }
}
