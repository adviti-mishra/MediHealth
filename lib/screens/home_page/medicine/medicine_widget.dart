import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/screens/home_page/medicine/medicine_details.dart';
import '../../../utils/utils_all.dart';

class MedicineWidget extends StatefulWidget {

  final String uID;
  final String docID;
  final String name;
  final String dosage;
  //final List<String> days;
  final String times;
  final String startDate;
  final String endDate;
  final String moreInfo;

  const MedicineWidget({
    required this.uID,
    required this.docID,
    required this.name,
    required this.dosage,
   // required this.days,
    required this.times,
    required this.startDate,
    required this.endDate,
    required this.moreInfo,

  });

  @override
  _MedicineWidgetState createState() => _MedicineWidgetState();
}

class _MedicineWidgetState extends State<MedicineWidget> {
  
  Column medicineCardContent() {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  MedicineDetails(
                uID: widget.uID,
                docID: widget.docID,
                name: widget.name,
                dosage: widget.dosage,
                times: widget.times,
                startDate: widget.startDate,
                endDate: widget.endDate,
                moreInfo: widget.moreInfo)
              ),
            );
          },
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          leading: medicinePicIcon(),
          title: Text(widget.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25)),
          trailing: deleteButton(context),
        ),
      ],
    );
  }

  Card medicineWidgetContent() {
    return Card(
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        color: Theme.of(context).colorScheme.secondary,
        child: medicineCardContent());
    // cancel
    // downarrow
  }

  RawMaterialButton deleteButton(context) {
  return RawMaterialButton(
      child: Icon(
        Icons.cancel_outlined,
        color: Theme.of(context).colorScheme.onError,
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
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.delete, color: Theme.of(context).colorScheme.primary),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Delete', style: TextStyle(color: Theme.of(context).colorScheme.secondary)))
        ],
      ),
      content: Text("Do you want to delete this?",
          style: TextStyle(color: ColorShades.text2)),
      actions: [
        TextButton(
            onPressed: () {
              FirebaseFirestore.instance.collection("user").doc(widget.uID).collection('medicines').doc(widget.docID).delete();
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            child: Text('Yes', style: TextStyle(color: ColorShades.text2))),
        TextButton(
            onPressed: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            child: Text('No', style: TextStyle(color: ColorShades.text2))),
      ]);
}

  @override
  Widget build(BuildContext context) {
    return medicineWidgetContent();
  }
}
