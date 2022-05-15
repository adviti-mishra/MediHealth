import 'package:flutter/material.dart';
import '../../constants/color_shades.dart';

class MedicineWidget extends StatefulWidget {
  const MedicineWidget({Key? key}) : super(key: key);
  @override
  _MedicineWidgetState createState() => _MedicineWidgetState();
}

class _MedicineWidgetState extends State<MedicineWidget> {
  Container medicineIcon() {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(right: 12),
      decoration:
          const BoxDecoration(border: Border(right: BorderSide(width: 2))),
      child: CircleAvatar(
        backgroundColor: ColorShades.text2,
        radius: 50,
        child: const CircleAvatar(
            backgroundImage: NetworkImage(
                'data:image/png;base64,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')),
      ),
    );
  }

  SingleChildScrollView medicineCardSubdetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // start date:
          Text('Start date: ',
              style: TextStyle(color: ColorShades.text2, fontSize: 20)),
          // end date:
          Text('End date: ',
              style: TextStyle(color: ColorShades.text2, fontSize: 20)),
          // Days: Monday, Wednesday, Friday
          Text('Days: Monday, Wednesday, Friday',
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
            "Do you want to delete this medicine?",
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

  ListTile medicineCardContent() {
    return ListTile(
      onTap: () {
        print('Open detailed Medicine card');
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      leading: medicineIcon(),
      title: Text('Medicine',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorShades.text2,
              fontSize: 40)),
      subtitle: medicineCardSubdetails(),
      trailing: deleteButton(),
    );
  }

  Card medicineWidgetContent() {
    return Card(
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        color: const Color(0xFFFFD700),
        child: medicineCardContent());
    // cancel
    // downarrow
  }

  @override
  Widget build(BuildContext context) {
    return medicineWidgetContent();
  }
}
