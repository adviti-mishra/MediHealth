import 'package:flutter/material.dart';
import '../../../../utils/utils_all.dart';

class EmergencyContactDetails extends StatefulWidget {
  const EmergencyContactDetails({Key? key}) : super(key: key);

  @override
  _EmergencyContactDetailsState createState() =>
      _EmergencyContactDetailsState();
}

class _EmergencyContactDetailsState extends State<EmergencyContactDetails> {

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
            child: const Text('AM', style: TextStyle(fontSize: 40))),
      ),
    );
  }

  Container emergencyContactDetails() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorShades.text1,
      ),
      child: Column(
        children: [
          verticalSpace(40),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: ColorShades.primaryColor3,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                // constrain height of List [Email, Password]
                child: Column(
                  children: [
                    verticalSpace(20),
                    Row(
                      children: [const Spacer(), deleteButton(context)],
                    ),
                    Expanded(child: emergencyContactIcon()),
                    verticalSpace(20),
                    // First name
                    userField(header_in: 'Name: ', content_in: 'Adviti Mishra'),
                    verticalSpace(20),
                    // Last name
                    userFieldIcon(
                        header_in: 'Phone: ',
                        content_in: '2694625272',
                        icon_in: Icons.call),
                    verticalSpace(20),
                    // Email
                    userFieldIcon(
                        header_in: 'Email: ',
                        content_in: 'advitimishra@gmail.com',
                        icon_in: Icons.mail),
                    // *******************************************************
                    verticalSpace(100),
                    // Login button
                    editButton(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Center(
              child: Text('Emergency contact details',
                  style: TextStyle(
                      fontFamily: 'Oleo Script Swash Caps',
                      color: ColorShades.text1,
                      fontSize: 40)))),
      body: emergencyContactDetails(),
    );
  }
}
