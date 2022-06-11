import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/screens/drawer_screens/emergency_contacts/add_emergency_contact.dart';
import '../../../utils/color_shades.dart';
import 'emergency_contact_details.dart';
import 'emergency_contact_widget.dart';

class EmergencyContactScreen extends StatelessWidget {
  final String userID;

  const EmergencyContactScreen({required this.userID});

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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddEmergencyContact(userID: uid)));
      },
    );
  }

  RawMaterialButton emergencyContactDetailsButton(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        Icons.info,
        color: ColorShades.text1,
        size: 40,
      ),
      shape: const CircleBorder(),
      onPressed: () {

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
            child: Text('Emergency Contacts',
                style: TextStyle(color: ColorShades.text1, fontSize: 30))),
        // Add a contact
        actions: [addButton(context), emergencyContactDetailsButton(context)],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(userID)
              .collection('emergencyContacts')
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
                      return EmergencyContactWidget(
                        uID: userID,
                        docID: index.toString(),
                        name: snapshot.data!.docs[index]['name'],
                        email: snapshot.data!.docs[index]['email'],
                        phoneNumber: snapshot.data!.docs[index]['phoneNumber'],
                      );
                    });
              }
            }
            return const Center(
              child: Text('error'),
            );
          }),
    );
  }
}
/*
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ;
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                return 
              } else {
                return const Center(
                  child: Text('There is no emergency contact yet'),
                );
              }
            }
            return const Center(
                child: Text(
              'Something went wrong',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ));
          },
        ));
        /*
        ListView.builder(itemBuilder: (BuildContext context, int index) {
          return const EmergencyContactWidget();
        })*/
        (/));
  
  }
}

  }
*/