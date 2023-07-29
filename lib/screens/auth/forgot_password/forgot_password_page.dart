import 'package:flutter/material.dart';
import '../../../utils/utils_all.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailTextController = TextEditingController();
  final _ForgetPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: forgetPasswordPageContent(),
    );
  }

// TO DO : implement forgotPasswordPageContent similar to loginPageContent
  Container forgetPasswordPageContent() {
    return Container();
  }

  // TO DO : implement submitButton similar to loginButton
  MaterialButton submitButton() {
    return MaterialButton(
      onPressed: _submitForgetPasswordForm,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
  }

  void _submitForgetPasswordForm() {
    final isValid = _ForgetPasswordFormKey.currentState!.validate();
    if (isValid) {}
  }

  Form email() {
    return Form(
      key: _ForgetPasswordFormKey,
      child: emailField(),
    );
  }

  Column emailField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: "Email: ")),
      emailValidation()
    ]);
  }

  TextFormField emailValidation() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextController,
      validator: (email) {
        if (email!.isEmpty || !email.contains('@')) {
          return "Please enter a valid email address";
        } else {
          return null;
        }
      },
      style: TextStyle(color: ColorShades.text2),
      decoration: InputDecoration(
        hintText: 'Format: someone@example.com',
        hintStyle:
            TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorShades.text1, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        fillColor: ColorShades.text1,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
