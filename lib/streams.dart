import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keepnotes/home_page.dart';
import 'package:keepnotes/splash_screen.dart';

class StreamsScreen extends StatefulWidget {
  const StreamsScreen({Key? key}) : super(key: key);

  @override
  State<StreamsScreen> createState() => _StreamsScreenState();
}

class _StreamsScreenState extends State<StreamsScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:  (context, snapshot) {
           if(snapshot.hasData){
             return const HomePage();
           }
           else{
             return const SplashScreen();
           }

        },);
  }
}
