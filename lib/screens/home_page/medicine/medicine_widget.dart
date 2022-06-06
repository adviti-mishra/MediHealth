import 'package:flutter/material.dart';
import '../../../utils/utils_all.dart';

class MedicineWidget extends StatefulWidget {
  const MedicineWidget({Key? key}) : super(key: key);
  @override
  _MedicineWidgetState createState() => _MedicineWidgetState();
}

class _MedicineWidgetState extends State<MedicineWidget> {

  SingleChildScrollView medicineCardSubdetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // start date:
          Text('Dosage: 20ml',
              style: TextStyle(color: ColorShades.text2, fontSize: 20)),
          // end date:
          Text('Times: 1PM, 6PM, 10PM',
              style: TextStyle(color: ColorShades.text2, fontSize: 20)),
          // Days: Monday, Wednesday, Friday
          Text('Days: Monday, Wednesday, Friday',
              style: TextStyle(color: ColorShades.text2, fontSize: 20)),
        ],
      ),
    );
  }

  Column medicineCardContent() {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          leading: medicinePicIcon(),
          title: const Text('Medicine',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25)),
          // subtitle: medicineCardSubdetails(),
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
        color: Colors.white,
        child: medicineCardContent());
    // cancel
    // downarrow
  }

  @override
  Widget build(BuildContext context) {
    return medicineWidgetContent();
  }
}
