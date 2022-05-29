import 'package:flutter/material.dart';
import '../../../utils/color_shades.dart';

class EmergencyContactWidget extends StatefulWidget {
  const EmergencyContactWidget({Key? key}) : super(key: key);
  @override
  _EmergencyContactWidgetState createState() => _EmergencyContactWidgetState();
}

class _EmergencyContactWidgetState extends State<EmergencyContactWidget> {
  Container emergencyContactIcon() {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(right: 12),
      decoration:
          const BoxDecoration(border: Border(right: BorderSide(width: 2))),
      child: CircleAvatar(
        backgroundColor: ColorShades.primaryColor1,
        radius: 50,
        child: const Text('AM')
      ),
    );
  }

  SingleChildScrollView emergencyContactCardSubdetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Phone number: 2694625272
          Text('Phone number: 2694625272',
              style: TextStyle(color: ColorShades.text2, fontSize: 20)),
          // Email: advitimishra@gmail.com
          Text('Email: advitimishra@gmail.com',
              style: TextStyle(color: ColorShades.text2, fontSize: 20)),
        ],
      ),
    );
  }

  RawMaterialButton deleteButton() {
    return RawMaterialButton(
        child: Icon(
          Icons.cancel_outlined,
          color: ColorShades.primaryColor1,
          size: 40,
        ),
        shape: const CircleBorder(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) {
              return deletePopup();
            },
          );
        });
  }

  AlertDialog deletePopup() {
    return AlertDialog(
        backgroundColor: ColorShades.text1,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.delete, color: ColorShades.primaryColor1),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('Delete', style: TextStyle(color: ColorShades.text2)))
          ],
        ),
        content: Text(
            "Do you want to delete this emergency contact?",
            style: TextStyle(color: ColorShades.text2)),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text('Yes',
                  style: TextStyle(color: ColorShades.text2))),
          TextButton(
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: Text('No', style: TextStyle(color: ColorShades.text2))),
        ]);
  }

  ListTile emergencyContactCardContent() {
    return ListTile(
      onTap: () {
        
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      leading: emergencyContactIcon(),
      title: Text('Adviti Mishra',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorShades.text2,
              fontSize: 40)),
      subtitle: emergencyContactCardSubdetails(),
      trailing: deleteButton(),
    );
  }

  Card emergencyContactWidgetContent() {
    return Card(
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        color: ColorShades.primaryColor3,
        child: emergencyContactCardContent());
    // cancel
    // downarrow
  }

  @override
  Widget build(BuildContext context) {
    return emergencyContactWidgetContent();
  }
}
