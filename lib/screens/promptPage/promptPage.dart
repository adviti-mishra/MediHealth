import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practice_app/utils/app_bar.dart';
import 'package:practice_app/utils/bottom_bar.dart';
import 'package:practice_app/utils/drawer_widget.dart';
import 'package:practice_app/utils/models.dart';
import '../../../../utils/utils_all.dart';
import 'package:practice_app/screens/promptPage/promptPage_message.dart';
import 'package:practice_app/screens/promptPage/promptPage_tile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PromptPage extends StatefulWidget {
  const PromptPage({Key? key}) : super(key: key);

  @override
  _PromptPageState createState() => _PromptPageState();
}

class _PromptPageState extends State<PromptPage> {
  final TextEditingController _responseTextController = TextEditingController();
  final _ResponseFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String prompt = "TEST";
  XFile? mediaFile; // The selected media file (photo, video, or voice memo)

  @override
  void initState() {
    super.initState();
    fetchPromptByPostDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: MediAppBar(importedKey: scaffoldKey),
      key: scaffoldKey,
      body: SingleChildScrollView(child: promptPageContent(context)),
      bottomNavigationBar: const BottomBar(),
    );
  }


  Future<void> fetchPromptByPostDate() async {
    try {
      var now = DateTime.now();
      var lastMidnight = DateTime(now.year, now.month, now.day);
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('prompts')
          .where('postDate', isEqualTo: lastMidnight)
          .get();

      if (snapshot.docs.isNotEmpty) {
        PromptsCustom promptData =
            PromptsCustom.fromFirestore(snapshot.docs[0], null);
        setState(() {
          prompt = promptData.prompt ?? "Default Prompt";
        });
      } else {
        setState(() {
          prompt = "No prompt found for today.";
        });
      }
    } catch (error) {
      print("Error fetching prompt: $error");
    }
  }

  Container promptPageContent(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorShades.text1,
      ),
      child: Column(
        children: [
          verticalSpace(20),
          promptPageMessage(context, prompt),
          enterResponseTile(
            response: response(),
            photoButton: photoButton(),
            videoButton: videoButton(),
            voiceMemoButton: voiceMemoButton(),
          ),
          submitButton(),
          verticalSpace(20),
        ],
      ),
    );
  }

  // implement submitting back end
  void _submitResponseForm() async {
    // input all logic
  }

  // response
  Form response() {
    return Form(
      key: _ResponseFormKey,
      child: responseField(),
    );
  }

  TextFormField responseField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      controller: _responseTextController,
      validator: (response) {
        if (response!.isEmpty) {
          return "Please enter a response or choose alternate media";
        } else {
          return null;
        }
      },
      maxLines: 14,
      style: TextStyle(
        color: ColorShades.text2,
        fontSize: 16 * fontSizeMultiplier,
      ),
      decoration: InputDecoration(
        hintText: 'Enter your response here...',
        hintStyle: TextStyle(
            fontSize: 16 * fontSizeMultiplier,
            color: ColorShades.grey,
            fontStyle: FontStyle.italic),
        filled: true,
        fillColor: ColorShades.text1,
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorShades.error, width: 2.0),
        ),
        errorStyle: TextStyle(
          color: ColorShades.error,
        ),
      ),
      cursorColor: ColorShades.text2,
    );
  }

  // Image and Video Selection
  Future<void> _selectImageOrVideo(ImageSource source, bool isVideo) async {
    XFile? pickedFile;

    if (isVideo) {
      pickedFile = await ImagePicker().pickVideo(source: source);
    } else {
      pickedFile = await ImagePicker().pickImage(source: source);
    }

    if (pickedFile != null) {
      setState(() {
        mediaFile = pickedFile;
      });
      // Do what you want with mediaFile here (e.g., upload it or display it on the page)
      _uploadMediaFile();
    }
  }

  Future<void> _uploadMediaFile() async {
  try {
    // Create a Reference to the file
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('responses/${mediaFile!.name}');

    // Upload the file
    UploadTask uploadTask = ref.putFile(File(mediaFile!.path));

    // Get the download URL
    await uploadTask.whenComplete(() async {
      final String downloadURL = await ref.getDownloadURL();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File uploaded successfully')),
      );

      // Update the UI with the file info
      setState(() {
        // store downloadURL to display later
      });
    });
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to upload file')),
    );
  }
}



  MaterialButton photoButton() {
    return MaterialButton(
      onPressed: () => _selectImageOrVideo(ImageSource.gallery, false),
      color: ColorShades.primaryColor1,
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(Icons.image, color: ColorShades.text1, size: 30)],
      ),
    );
  }

  MaterialButton videoButton() {
    return MaterialButton(
      onPressed: () => _selectImageOrVideo(ImageSource.gallery, true),
      color: ColorShades.primaryColor1,
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(Icons.videocam, color: ColorShades.text1, size: 30)],
      ),
    );
  }

  void _recordVoiceMemo() {
    // Placeholder: Add code to record a voice memo here
    // You can use a package like audioplayers or flutter_sound
    print("Voice memo recording feature is not yet implemented");
  }

  MaterialButton voiceMemoButton() {
    return MaterialButton(
      onPressed: _recordVoiceMemo,
      color: ColorShades.primaryColor1,
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(Icons.mic, color: ColorShades.text1, size: 30)],
      ),
    );
  }

  Container submitButton() {
    return Container(
        width: 200,
        child: MaterialButton(
          onPressed: _submitResponseForm,
          color: ColorShades.primaryColor1,
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Send',
                style: TextStyle(
                  color: ColorShades.text1,
                  fontWeight: FontWeight.bold,
                  fontSize: 20 * fontSizeMultiplier,
                ),
              ),
              Icon(
                Icons.done,
                color: ColorShades.text1,
              )
            ],
          ),
        ));
  }
}
