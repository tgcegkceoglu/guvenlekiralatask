import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guvenlekirala/view/expressYourself.dart';
import 'package:guvenlekirala/view/homePage.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color(0xFF006AFF),));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontFamily: "Montserrat",fontSize: 18,color:Color(0xFF3A3335)),
          headlineMedium: TextStyle(fontFamily: "Montserrat",fontSize: 16,color: Color(0xFF484848)),
          bodySmall: TextStyle(fontFamily: "Montserrat",fontSize: 14,color: Color(0xFF908E8E)),
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/expressYourself': (context) => const ExpressYourself(),
      },
    );
  }
}
