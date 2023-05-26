import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'app_Style.dart';

class NoteReaderScreen extends StatefulWidget {
  const NoteReaderScreen(this.doc, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot? doc;
 // final DocumentSnapshot  documentInsideCollection ;
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {

  @override
  Widget build(BuildContext context) {
    // this height is height=10
    final height = MediaQuery.of(context).size.height/80;
    int color_id = widget.doc?['color_id'];
    var collectionData = FirebaseFirestore.instance.collection('Notes').snapshots();

    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(  'Title: ',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold) ) ,
                 Text('  ${widget.doc?['note_title']}', style: AppStyle.mainTitle,),
              ],
            ),
            SizedBox(height: height/2,),
            Row(
              children: [
               const Text(  'Date: ',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold) ) ,
                Text(  '  ${widget.doc?['creation_date']}', style: AppStyle.dateTitle,),
              ],
            ),
            SizedBox(height: height,),
            Row(
              children: [
                const Text(  'Content: ',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold) ) ,
                Text( '  ${widget.doc?['note_content']}', style: AppStyle.mainContent,),
              ],
            ),

          ],
        ),
      ),
      floatingActionButton: ElevatedButton(onPressed: () async{
        await FirebaseFirestore.instance.collection('Notes').doc(widget.doc?.id).delete();
        Navigator.pop(context);
        }, child: const Text('delete') ,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}
