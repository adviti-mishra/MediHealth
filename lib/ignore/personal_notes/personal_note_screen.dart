import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/ignore/personal_notes/personal_note_widget.dart';
import '../../../utils/color_shades.dart';
import 'add_personal_note.dart';

class PersonalNoteScreen extends StatelessWidget {
  final String userID;

  const PersonalNoteScreen({Key? key, required this.userID}) : super(key: key);

  RawMaterialButton addButton(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        Icons.add_circle_outline,
        color: ColorShades.text1,
        size: 60,
      ),
      shape: const CircleBorder(),
      onPressed: () {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        final User? user = _auth.currentUser;
        final String uid = user!.uid;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddNote(userID: uid)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorShades.primaryColor3,
      appBar: AppBar(
        backgroundColor: ColorShades.primaryColor1,
        // Back to Menu
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
        // Emergency Contacts
        title: FittedBox(
            fit: BoxFit.contain,
            child: Text('Personal notes',
                style: TextStyle(color: ColorShades.text1, fontSize: 30))),
        // Add a contact
        actions: [addButton(context)],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(userID)
              .collection('notes')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return PersonalNoteWidget(
                        uID: userID,
                        docID: snapshot.data!.docs[index].id
                            .toString(), //index.toString(),
                        title: snapshot.data!.docs[index]['title'],
                        content: snapshot.data!.docs[index]['content'],
                      );
                    });
              }
            }
            return const Center(
              child: Text('No notes have been added yet'),
            );
          }),
    );
  }
}
