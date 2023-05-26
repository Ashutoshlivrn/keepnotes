import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keepnotes/app_Style.dart';
Widget noteCard( Function()? onTap, QueryDocumentSnapshot? doc,BuildContext context) {
  // this height is height=10
  final height = MediaQuery.of(context).size.height/80;
return InkWell(
  onTap: onTap,
  child: Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: AppStyle.cardsColor[doc?['color_id']],
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text( doc?['note_title'], style: AppStyle.mainTitle,),
        SizedBox(height: height/2,),
        Text( doc?['creation_date'], style: AppStyle.dateTitle,),
        SizedBox(height: height,),
        Text( doc?['note_content'], style: AppStyle.mainContent,overflow: TextOverflow.ellipsis),


      ],
    ),
  ),
);
}