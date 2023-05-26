import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:keepnotes/auth_class.dart';

import 'package:keepnotes/app_Style.dart';
import 'package:keepnotes/note_cards.dart';
import 'package:keepnotes/note_editor.dart';
import 'package:keepnotes/note_reader.dart';
import 'package:keepnotes/sign_in_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  deleteTap(id) {
    FirebaseFirestore.instance.collection('Notes').doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {

    var firebaseUser = FirebaseAuth.instance.currentUser!;
    void handleClick(int item) {
      switch (item) {
        case 0:
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Do you really wish to logout?'),
                actions: [
                  ElevatedButton(onPressed: () async{
                    await ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('logging out')));
                    //await Timer(Duration(seconds: 3), () { });
                    await Auth().logOutFromFirebaseAccount();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginPage() ));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('logged out')));
                  } , child: Text('Yes')),
                  SizedBox(width: 10,),
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text('No')),
                ],
                  backgroundColor: Colors.grey

              );
            },
          );
          break;
        case 1:
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Delete your account?'),
                actions: [
                  ElevatedButton(onPressed: () async{
                    await ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deleting account')));
                    await firebaseUser.delete();
                    await GoogleSignIn().signOut();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account deleted')));
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginPage()  ));
                  }, child: Text('Yes')),
                  SizedBox(width: 10,),
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text('No'))
                ],
                backgroundColor: Colors.grey,
              );
            },
          );
          break;
      }
    }

    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
          elevation: 0.0,
          title: Text('KEEP NOTES'),
          centerTitle: true,
          backgroundColor: AppStyle.mainColor,
          actions: <Widget>[
            PopupMenuButton<int>(
                onSelected: (item) => handleClick(item),
                itemBuilder: (context) => [
                      PopupMenuItem<int>(value: 0, child: Text('Logout')),
                      PopupMenuItem<int>(value: 1, child: Text('Delete Account')),
                    ],
                icon: Icon(Icons.settings)),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'your recent notes',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Notes').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    //  print( snapshot.data!.docs.map((e) => null) );
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        var mydoc = snapshot.data?.docs[index];
                        return noteCard(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NoteReaderScreen(mydoc)));
                        }, mydoc,context);
                      },
                    );
                    //   GridView(
                    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisSpacing: 10,
                    //       mainAxisSpacing: 10,
                    //       crossAxisCount: 2),
                    //       children: snapshot.data!.docs.map((note) => noteCard(
                    //           (){
                    //             Navigator.push(context, MaterialPageRoute(builder: (context) => NoteReaderScreen(note ,
                    //             )));
                    //           }, note))
                    //       .toList(),
                    // );
                  }

                  return Text(
                    'there\'s no data',
                    style: GoogleFonts.nunito(color: Colors.white),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteEditorScreen(),
              ));
        },
        label: Text('Add one?'),
        icon: Icon(Icons.add),
      ),
    );
  }
  // deleteTap( id){
  //   FirebaseFirestore.instance.collection('Notes').doc(id).delete();
  // }
}
