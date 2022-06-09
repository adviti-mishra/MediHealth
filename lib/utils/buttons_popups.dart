import 'package:flutter/material.dart';
import 'package:practice_app/utils/color_shades.dart';

void editPopup(context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          backgroundColor: ColorShades.text1,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.logout, color: ColorShades.primaryColor1),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text('Edit', style: TextStyle(color: ColorShades.text2)))
            ],
          ),
          content: Text("Do you want to edit this?",
              style: TextStyle(color: ColorShades.text2)),
          actions: [
            TextButton(
                onPressed: () {},
                child: Text('Yes', style: TextStyle(color: ColorShades.text2))),
            TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text('No', style: TextStyle(color: ColorShades.text2))),
          ]);
    },
  );
}

MaterialButton editButton(context) {
  return MaterialButton(
    onPressed: () {
      editPopup(context);
    },
    color: ColorShades.primaryColor1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Edit',
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
            Icons.edit,
            color: ColorShades.text1,
          )
        ],
      ),
    ),
  );
}

RawMaterialButton deleteButton(context) {
  return RawMaterialButton(
        child: const Icon(
          Icons.cancel_outlined,
          color: Colors.red,
          size: 60,
        ),
        shape: const CircleBorder(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) {
              return deletePopup(context);
            },
          );
        });
}

AlertDialog deletePopup(context) {
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
              child: Text('Delete', style: TextStyle(color: ColorShades.text2)))
        ],
      ),
      content: Text("Do you want to delete this?",
          style: TextStyle(color: ColorShades.text2)),
      actions: [
        TextButton(
            onPressed: () {},
            child: Text('Yes', style: TextStyle(color: ColorShades.text2))),
        TextButton(
            onPressed: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            child: Text('No', style: TextStyle(color: ColorShades.text2))),
      ]);
}

Container medicinePicIcon() {
  return Container(
    height: 200,
    width: 100,
    padding: const EdgeInsets.only(right: 12),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.black, width: 4.0),
      image: const DecorationImage(
          image: NetworkImage(
              'https://cdn-icons-png.flaticon.com/512/172/172835.png'),
          fit: BoxFit.fill),
    ),
  );
}

void errorPopup(context, error) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          backgroundColor: ColorShades.text1,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.error_outline, color: ColorShades.primaryColor1),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text('Error occured', style: TextStyle(color: ColorShades.text2)))
            ],
          ),
          content: Text(error,
              style: TextStyle(color: ColorShades.text2)),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text('Ok', style: TextStyle(color: ColorShades.text2))),
          ]);
    },
  );
}

