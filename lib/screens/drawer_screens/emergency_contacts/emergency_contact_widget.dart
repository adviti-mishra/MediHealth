import 'package:flutter/material.dart';
import '../../../utils/utils_all.dart';

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
      //decoration:
      //const BoxDecoration(border: Border(right: BorderSide(width: 2))),
      child: CircleAvatar(
          backgroundColor: ColorShades.primaryColor1,
          radius: 50,
          child: const Text('AM')),
    );
  }

  SingleChildScrollView emergencyContactCardSubdetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Phone number: 2694625272
          Text('Phone number: ',
              style: TextStyle(color: ColorShades.text2, fontSize: 20)),
          Text('2694625272',
              style: TextStyle(color: ColorShades.text2, fontSize: 20)),
          // Email: advitimishra@gmail.com
          Text('Email: ',
              style: TextStyle(color: ColorShades.text2, fontSize: 20)),
          Text('advitimishra@gmail.com',
              style: TextStyle(color: ColorShades.text2, fontSize: 20)),
        ],
      ),
    );
  }

  ListTile emergencyContactCardContent() {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      leading: emergencyContactIcon(),
      title: const Text('Adviti Mishra',
          maxLines: 2,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20)),
      trailing: deleteButton(context),
    );
    ;
  }

  Card emergencyContactWidgetContent() {
    return Card(
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        color: ColorShades.primaryColor2,
        child: emergencyContactCardContent());
    // cancel
    // downarrow
  }

  @override
  Widget build(BuildContext context) {
    return emergencyContactWidgetContent();
  }
}
