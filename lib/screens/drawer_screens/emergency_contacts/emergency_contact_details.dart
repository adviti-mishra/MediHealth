import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../../utils/utils_all.dart';
import '../../../utils/text_to_speach.dart';

class EmergencyContactDetails extends StatefulWidget {
  
  final String uID;
  final String docID;
  final String name;
  final String email;
  final String phoneNumber;

  const EmergencyContactDetails({
    required this.uID,
    required this.docID,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  @override
  _EmergencyContactDetailsState createState() =>
      _EmergencyContactDetailsState();
}

class _EmergencyContactDetailsState extends State<EmergencyContactDetails> {

  final FlutterTts flutterTts = FlutterTts();

  Container emergencyContactIcon() {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(right: 12),
      child: CircleAvatar(
        backgroundColor: ColorShades.text2,
        radius: 80,
        child: CircleAvatar(
            backgroundColor: ColorShades.primaryColor1,
            radius: 70,
            child: const Icon(Icons.person)//const Text('AM', style: TextStyle(fontSize: 40))),
      ),
      )
    );
  }
  
  void deleteContact(){
    FirebaseFirestore.instance.collection("user").doc(widget.uID).collection('emergencyContacts').doc(widget.docID).delete();
  }
  
  Container emergencyContactDetails() {
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
                              'Name: ${widget.name}, Phone: ${widget.phoneNumber}, Email: ${widget.email}',
                              flutterTts),
                       ),
                      Row(
                        children: [
                          emergencyContactIcon(),
                          const Spacer(),
                          deleteButton(context, deleteContact)
                        ],
                      ),
                      verticalSpace(20),
                      // First name
                      userField(header_in: 'Name: ', content_in: widget.name),
                      verticalSpace(20),
                      // Last name
                      userFieldIcon(
                          header_in: 'Phone: ',
                          content_in: widget.phoneNumber,
                          icon_in: Icons.call,
                          dataHeader: widget.phoneNumber),
                      verticalSpace(20),
                      // Email
                      userFieldIcon(
                          header_in: 'Email: ',
                          content_in: widget.email,
                          icon_in: Icons.mail,
                          dataHeader: widget.email),
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
                child:  Text('Emergency contact details',
                  style: TextStyle(color: ColorShades.text1)))),
      body: emergencyContactDetails(),
    );
  }
}
