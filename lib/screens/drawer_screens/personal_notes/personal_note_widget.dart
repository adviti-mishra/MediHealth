import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/screens/drawer_screens/personal_notes/personal_note_details.dart';
import '../../../utils/utils_all.dart';

class PersonalNoteWidget extends StatefulWidget {
  final String uID;
  final String docID;
  final String title;
  final String content;

  const PersonalNoteWidget({Key? key, 
    required this.uID,
    required this.docID,
    required this.title,
    required this.content,
  }) : super(key: key);
  @override
  _PersonalNoteWidgetState createState() => _PersonalNoteWidgetState();
}

class _PersonalNoteWidgetState extends State<PersonalNoteWidget> {
  bool _isLoading = false;
  String title = "";
  String content = "";
  String createdAt = "";

  void getUserData() async {
    try {
      _isLoading = true;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(widget.uID)
          .collection('notes')
          .doc(widget.docID)
          .get();
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          title = userDoc.get('email');
          content = userDoc.get('name');
        });
      }
    } finally {
      _isLoading = false;
    }
  }

  Container noteIcon() {
    return Container(
        height: 200,
        padding: const EdgeInsets.only(right: 12),
        //decoration:
        //const BoxDecoration(border: Border(right: BorderSide(width: 2))),
        child: CircleAvatar(
            backgroundColor: ColorShades.primaryColor1,
            radius: 50,
            child: const Icon(Icons.note)) //Text(widget.name)),
        );
  }

  ListTile noteCardContent() {
    return ListTile(
      onTap: () {
        Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  NoteDetails(
            uID: widget.uID, docID: widget.docID, title: widget.title, content: widget.content)
              ),
            );
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      leading: noteIcon(),
      title: Text(widget.title,
          maxLines: 2,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20)),
      trailing: deleteButton(context),
    );
  }
  void deleteNote(){
    FirebaseFirestore.instance.collection("user").doc(widget.uID).collection('notes').doc(widget.docID).delete();
  }

  Card noteWidgetContent() {
    return Card(
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        color: ColorShades.primaryColor2,
        child: noteCardContent());
    // cancel
    // downarrow
  }

  RawMaterialButton deleteButton(context) {
  return RawMaterialButton(
      child: const Icon(
        Icons.cancel_outlined,
        color: Colors.red,
        size: 60,
      ),
      shape: const CircleBorder(),
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) {
            return deletePopup(context);
          },
        );
      });
}

AlertDialog deletePopup(context) {
  return AlertDialog(
      backgroundColor: ColorShades.text1,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.delete, color: ColorShades.primaryColor1),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Delete', style: TextStyle(color: ColorShades.text2)))
        ],
      ),
      content: Text("Do you want to delete this?",
          style: TextStyle(color: ColorShades.text2)),
      actions: [
        TextButton(
            onPressed: () {
              FirebaseFirestore.instance.collection("user").doc(widget.uID).collection('emergencyContacts').doc(widget.docID).delete();
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            child: Text('Yes', style: TextStyle(color: ColorShades.text2))),
        TextButton(
            onPressed: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            child: Text('No', style: TextStyle(color: ColorShades.text2))),
      ]);
}

  @override
  Widget build(BuildContext context) {
    return noteWidgetContent();
  }
}
