import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../../utils/utils_all.dart';
import '../../../utils/text_to_speach.dart';

class NoteDetails extends StatefulWidget {
  
  final String uID;
  final String docID;
  final String title;
  final String content;

  const NoteDetails({Key? key, 
    required this.uID,
    required this.docID,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  _NoteDetailsState createState() =>
      _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {

  final FlutterTts flutterTts = FlutterTts();

  Container noteIcon() {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(right: 12),
      child: CircleAvatar(
        backgroundColor: ColorShades.text2,
        radius: 80,
        child: CircleAvatar(
            backgroundColor: ColorShades.primaryColor1,
            radius: 70,
            child: const Icon(Icons.note)//const Text('AM', style: TextStyle(fontSize: 40))),
      ),
      )
    );
  }
  
  void deleteNote(){
    FirebaseFirestore.instance.collection("user").doc(widget.uID).collection('notes').doc(widget.docID).delete();
  }
  
  Container noteDetails() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorShades.primaryColor3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(40),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: ColorShades.primaryColor2,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60)),
                  border: Border.all(color: ColorShades.text2, width: 2)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    height: 600, // constrain height of List [Email, Password]
                      child: ListView(
                                     // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      verticalSpace(20),
                       Align(
                         alignment: Alignment.centerLeft,
                         child: audio(
                              'Title: ${widget.title}, Content: ${widget.content}',
                              flutterTts),
                       ),
                      Row(
                        children: [
                          noteIcon(),
                          const Spacer(),
                          deleteButton(context, deleteNote)
                        ],
                      ),
                      verticalSpace(20),
                      // First name
                      userField(header_in: 'Title: ', content_in: widget.title),
                      verticalSpace(20),
                      // Last name
                      userField(header_in: 'Content: ', content_in: widget.content),
                      // *******************************************************
                      verticalSpace(100),
                      // Login button
                      editButton(context),
                                      ],
                     ),
                    ),
              ),
            ),
          ),
            )
        ],
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorShades.primaryColor3,
      appBar: AppBar(
          backgroundColor: ColorShades.primaryColor1,
          // Back button
          leading: Builder(
            builder: (ctx) {
              return IconButton(
                icon: Icon(Icons.arrow_back_ios_new_outlined,
                    color: ColorShades.text1),
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
              );
            },
          ),
          // Medicine details
          title: FittedBox(
                fit: BoxFit.contain,
                child:  Text('Note details',
                  style: TextStyle(color: ColorShades.text1)))),
      body: noteDetails(),
    );
  }
}
