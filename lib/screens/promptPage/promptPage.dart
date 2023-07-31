import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/screens/auth/signup/signup.dart';
import '../../../utils/utils_all.dart';
import 'package:practice_app/screens/auth/welcome/welcome_page.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: promptPageContent(context),
    );
  }

  Container promptPageContent(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          verticalSpace(120),
          promptPageMessage(context),
          enterResponseTile(
            response: response(),
            photoButton: photoButton(),          
            videoButton: videoButton(),
            voiceMemoButton: voiceMemoButton(),
          ),
          submitButton(),
          backWelcomeButton(),
        ],
      ),
    );
  }

  // implement submitting back end
  void _submitResponseForm() async{
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
      keyboardType: TextInputType.emailAddress,
      controller: _responseTextController,
      validator: (email) {
        if (email!.isEmpty) {
          return "Please enter a response or choose alternate media";
        } 
        else {
          return null;
        }
      },
      maxLines: 16,
      style: TextStyle(color: ColorShades.text2),
      decoration: InputDecoration(
        hintText: 'Enter your response here...',
        hintStyle:
            TextStyle(fontSize: 18, color: Colors.grey[600], fontStyle: FontStyle.italic),
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        errorStyle: TextStyle(
          color: Colors.red,
        ),
      ),
    cursorColor: Colors.black,
    );
  }

  MaterialButton photoButton() {
    return MaterialButton(
      onPressed: _submitResponseForm,
      color: Color(0xff102542),
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.image,
            color: Colors.white,
            size: 30
          )
        ],
      ),
    );
  }

  MaterialButton videoButton() {
    return MaterialButton(
      onPressed: _submitResponseForm,
      color: Color(0xff102542),
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.videocam,
            color: Colors.white,
            size: 30
          )
        ],
      ),
    );
  }

  MaterialButton voiceMemoButton() {
    return MaterialButton(
      onPressed: _submitResponseForm,
      color: Color(0xff102542),
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.mic,
            color: Colors.white,
            size: 30
          )
        ],
      ),
    );
  }

  Container submitButton() {
    return Container(
      width: 200,
      child:MaterialButton(
        onPressed: _submitResponseForm,
        color: Color(0xff102542),
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Send',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Icon(
              Icons.done,
              color: Colors.white,
            )
          ],
        ),
      )
    );
  }

  // Back Button to be deleted
  TextButton backWelcomeButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Welcome()
          )
        );
      },
      child: const Text(
        "Back",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      )
    );
  }
}
