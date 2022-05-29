import 'package:flutter/material.dart';
import 'package:practice_app/screens/drawer_screens/emergency_contacts/add_emergency_contact.dart';
import '../../../utils/color_shades.dart';
import 'emergency_contact_details.dart';
import 'emergency_contact_widget.dart';

class EmergencyContactScreen extends StatelessWidget {
  const EmergencyContactScreen({Key? key}) : super(key: key);

  RawMaterialButton addButton(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        Icons.add_circle_outline,
        color: ColorShades.text1,
        size: 40,
      ),
      shape: const CircleBorder(),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddEmergencyContact()));
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EmergencyContactDetails()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Center(
              child: Text('Emergency Contacts',
                  style: TextStyle(
                      fontFamily: 'Oleo Script Swash Caps',
                      color: ColorShades.text1,
                      fontSize: 40))),
          // Add a contact
          actions: [addButton(context), emergencyContactDetailsButton(context)],
        ),
        body: ListView.builder(itemBuilder: (BuildContext context, int index) {
          return const EmergencyContactWidget();
        }));
  }
}
