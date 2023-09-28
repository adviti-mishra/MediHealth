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
  Future<void> _selectImageOrVideo(ImageSource source) async {
    XFile? mediaFile;
    if (source == ImageSource.gallery) {
      mediaFile = await ImagePicker().pickImage(source: source);
    } else if (source == ImageSource.camera) {
      mediaFile = await ImagePicker()
          .pickVideo(source: source, maxDuration: const Duration(seconds: 60));
    }

    if (mediaFile != null) {
      // Handle the selected media file (image or video) here.
      // You can store the file path or display the media using a video player or image widget.
      // For example, if it's a video, you can initialize a VideoPlayerController and show the video.
    }
  }

  MaterialButton photoButton() {
    return MaterialButton(
      onPressed: () => _selectImageOrVideo(ImageSource.gallery),
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
      onPressed: () => _selectImageOrVideo(ImageSource.gallery),
      color: ColorShades.primaryColor1,
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(Icons.videocam, color: ColorShades.text1, size: 30)],
      ),
    );
  }

  MaterialButton voiceMemoButton() {
    return MaterialButton(
      onPressed: _submitResponseForm,
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
