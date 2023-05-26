import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keepnotes/app_Style.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String nowDate = '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';


  @override
  Widget build(BuildContext context) {
    // this height is height=10
    final height = MediaQuery.of(context).size.height/80;

    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        title: const Text('add a new note',style: TextStyle(color: Colors.black),),
        iconTheme: const IconThemeData( color: Colors.black ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller:  _titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: height,),
            Text(nowDate, style: AppStyle.dateTitle ,),
            SizedBox(height: height*3,),
            TextField(
              controller:  _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Body',
              ),
              style: AppStyle.mainTitle,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
          onPressed: () async{
             FirebaseFirestore.instance.collection('Notes').add( {
               'note_title' : _titleController.text,
               'creation_date': nowDate,
               'note_content': _mainController.text,
               'color_id': color_id,
             }).then((value) {

               Navigator.pop(context);
             });
          },
        child: const Icon(Icons.save),
      ),

    );
  }
}
