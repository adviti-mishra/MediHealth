import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/screens/drawer_screens/emergency_contacts/emergency_contact_details.dart';
import '../../../utils/utils_all.dart';

class EmergencyContactWidget extends StatefulWidget {
  final String uID;
  final String docID;
  final String name;
  final String email;
  final String phoneNumber;

  const EmergencyContactWidget({
    required this.uID,
    required this.docID,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
  @override
  _EmergencyContactWidgetState createState() => _EmergencyContactWidgetState();
}

class _EmergencyContactWidgetState extends State<EmergencyContactWidget> {
  bool _isLoading = false;
  String phoneNumber = "";
  String name = "";
  String email = "";
  String createdAt = "";

  void getUserData() async {
    try {
      _isLoading = true;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(widget.uID)
          .collection('emergencyContacts')
          .doc(widget.docID)
          .get();
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          email = userDoc.get('email');
          name = userDoc.get('name');
          phoneNumber = userDoc.get('phoneNumber');
        });
      }
    } catch (error) {
    } finally {
      _isLoading = false;
    }
  }

  Container emergencyContactIcon() {
    return Container(
        height: 200,
        padding: const EdgeInsets.only(right: 12),
        //decoration:
        //const BoxDecoration(border: Border(right: BorderSide(width: 2))),
        child: CircleAvatar(
            backgroundColor: ColorShades.primaryColor1,
            radius: 50,
            child: const Icon(Icons.person)) //Text(widget.name)),
        );
  }

  SingleChildScrollView emergencyContactCardSubdetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Phone number: 2694625272
          Text('Phone number: ',
              style: TextStyle(color: ColorShades.text2, fontSize: 20)),
          Text(phoneNumber,
              style: TextStyle(color: ColorShades.text2, fontSize: 20)),
          // Email: advitimishra@gmail.com
          Text('Email: ',
              style: TextStyle(color: ColorShades.text2, fontSize: 20)),
          Text(email, style: TextStyle(color: ColorShades.text2, fontSize: 20)),
        ],
      ),
    );
  }

  ListTile emergencyContactCardContent() {
    return ListTile(
      onTap: () {
        Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  EmergencyContactDetails(
            name: widget.name, email: widget.email, phoneNumber: widget.phoneNumber)
              ),
            );
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      leading: emergencyContactIcon(),
      title: Text(widget.name,
          maxLines: 2,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20)),
      trailing: deleteButton(context, deleteContact),
    );
  }
  void deleteContact(){
    FirebaseFirestore.instance.collection("user").doc(widget.uID).collection('emergencyContacts').doc(widget.docID).delete();
  }

  Card emergencyContactWidgetContent() {
    return Card(
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        color: ColorShades.primaryColor2,
        child: emergencyContactCardContent());
    // cancel
    // downarrow
  }

  @override
  Widget build(BuildContext context) {
    return emergencyContactWidgetContent();
  }
}
