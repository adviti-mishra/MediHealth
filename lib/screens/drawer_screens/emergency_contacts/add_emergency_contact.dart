import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:practice_app/utils/utils_all.dart';

import '../../../utils/text_to_speach.dart';

class AddEmergencyContact extends StatefulWidget {
  final String userID;
  const AddEmergencyContact({Key? key, required this.userID}) : super(key: key);

  @override
  _AddEmergencyContact createState() => _AddEmergencyContact();
}

class _AddEmergencyContact extends State<AddEmergencyContact> {
  // initializing TextEditingControllers
  final TextEditingController _contactNameTextController =
      TextEditingController();
  final TextEditingController _contactNumberTextController =
      TextEditingController();
  final TextEditingController _contactEmailTextController =
      TextEditingController();

  final _uploadContactFormKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
  }
  // deconstructor : TextEditingControllers
  @override
  void dispose() {
    super.dispose();
    _contactNameTextController.dispose();
    _contactNumberTextController.dispose();
    _contactEmailTextController.dispose();
  }

  void _uploadContactForm() {
    final User? user = _auth.currentUser;
    final _uid = user!.uid;
    final isValid = _uploadContactFormKey.currentState!.validate();
    if (isValid) {

      final data = {
        "name": _contactNameTextController.text,
        "phoneNumber": _contactNumberTextController.text,
        "email": _contactEmailTextController.text
      };

      FirebaseFirestore.instance.collection('user').doc(_uid).collection('emergencyContacts').add(data);

       Navigator.canPop(context) ? Navigator.pop(context) : null;
    } else {}
  }

  InkWell fieldValidation(
      {required String valueKey,
      required TextEditingController controller,
      required bool enabled,
      required Function ftor,
      required int maxlength}) {
    return InkWell(
      onTap: () {
        ftor();
      },
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        key: ValueKey(valueKey),
        maxLength: maxlength,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please fill this field";
          } else {
            return null;
          }
        },
        style: TextStyle(color: ColorShades.text2),
        decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          fillColor: ColorShades.text1,
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }

  Form nameNumberEmail() {
    return Form(
      key: _uploadContactFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name:
          contactNameField(),
          // BLANK LINE
          verticalSpace(20),
          // Phone number:
          contactNumberField(),
          // BLANK LINE
          verticalSpace(20),
          // Email:
          contactEmailField(),
          // BLANK LINE
          verticalSpace(20),
          // Upload Contact BUTTON
          uploadContactButton(),
        ],
      ),
    );
  }

  Column contactNameField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: 'Name: ')),
      fieldValidation(
          valueKey: 'contactName',
          controller: _contactNameTextController,
          enabled: true,
          ftor: () {},
          maxlength: 100)
    ]);
  }

  Column contactNumberField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: 'Phone number: ')),
      fieldValidation(
          valueKey: 'contactNumber',
          controller: _contactNumberTextController,
          enabled: true,
          ftor: () {},
          maxlength: 100)
    ]);
  }

  Column contactEmailField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: 'Email: ')),
      fieldValidation(
          valueKey: 'contactEmail',
          controller: _contactEmailTextController,
          enabled: true,
          ftor: () {},
          maxlength: 100)
    ]);
  }

  MaterialButton uploadContactButton() {
    return MaterialButton(
      onPressed: _uploadContactForm,
      color: ColorShades.primaryColor1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add contact ',
              style: TextStyle(
                color: ColorShades.text1,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.upload_file_outlined,
              color: ColorShades.text1,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorShades.primaryColor3,
      appBar: AppBar(
        backgroundColor: ColorShades.primaryColor1,
        title: FittedBox(
            fit: BoxFit.contain,
            child: Text('Add an emergency contact',
                style: TextStyle(
                  color: ColorShades.text1,
                ))),
        leading: Builder(
          builder: (ctx) {
            return IconButton(
              icon: Icon(Icons.arrow_back_ios_new_sharp,
                  color: ColorShades.text1),
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
            );
          },
        ),
      ),
      body: Card(
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        color: ColorShades.primaryColor2,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
             Padding(
                padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: audio(
                          'Please enter the following fields for your emergency contact:  their Name, Phone number, and email ',
                          flutterTts),
                    )
                    ),
            // Medicine Information
            Padding(
                padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
                child: Align(
                    alignment: Alignment.center,
                    child: Text('Emergency Contact Information',
                        style: TextStyle(
                            color: ColorShades.text2,
                            fontWeight: FontWeight.bold,
                            fontSize: 40)))),
            const SizedBox(height: 10),
            //__________________________
            const Divider(thickness: 1),
            // <body>
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: nameNumberEmail(),
            )
          ]),
        ),
      ),
    );
  }
}
