import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keepnotes/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:keepnotes/splash_screen.dart';




import 'package:keepnotes/streams.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: //ThisHomePage(),
      //SignUpPage(),
      //SplashScreen(),
      //rough(),
      //HomePage(),
        //MyCustomWidget(),
      //LoginPage(),
      StreamsScreen(),
      //SplashScreen(),
      //SignUpPage(),
    );
  }
}
