import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/utils/app_bar.dart';
import 'package:practice_app/utils/bottom_bar.dart';
import 'package:practice_app/utils/drawer_widget.dart';
import '../../../../utils/utils_all.dart';
import 'package:practice_app/screens/promptPage/promptPage_message.dart';
import 'package:practice_app/screens/promptPage/promptPage_tile.dart';

class PromptPage extends StatefulWidget {
  const PromptPage({Key? key}) : super(key: key);

  @override
  _PromptPageState createState() => _PromptPageState();
}

class _PromptPageState extends State<PromptPage> {
  final TextEditingController _responseTextController = TextEditingController();
  final _ResponseFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: MediAppBar(importedKey: scaffoldKey),
      key: scaffoldKey,
      body:  SingleChildScrollView(child: promptPageContent(context)),
      bottomNavigationBar: const BottomBar(),
    );
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
          promptPageMessage(context),
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
      maxLines: 16,
      style: TextStyle(
      color: ColorShades.text2,
      fontSize: 16 * fontSizeMultiplier,
    ),
      decoration: InputDecoration(
        hintText: 'Enter your response here...',
        hintStyle: TextStyle(
            fontSize: 16 * fontSizeMultiplier, color: ColorShades.grey, fontStyle: FontStyle.italic),
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

  MaterialButton photoButton() {
    return MaterialButton(
      onPressed: _submitResponseForm,
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
      onPressed: _submitResponseForm,
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
