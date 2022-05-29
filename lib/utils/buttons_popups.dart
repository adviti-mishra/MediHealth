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

