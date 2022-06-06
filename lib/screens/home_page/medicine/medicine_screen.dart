import 'package:flutter/material.dart';
import 'package:practice_app/screens/home_page/medicine/medicine_details.dart';
import 'add_medicine.dart';
import '../drawer_widget.dart';
import 'medicine_widget.dart';
import '../../../../utils/color_shades.dart';

class MedicineScreen extends StatelessWidget {
  const MedicineScreen({Key? key}) : super(key: key);

  RawMaterialButton addButton(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        Icons.add_circle_outline,
        color: ColorShades.text1,
        size: 60,
      ),
      shape: const CircleBorder(),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddMedicine()));
      },
    );
  }

  RawMaterialButton medicineDetailsButton(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        Icons.info,
        color: ColorShades.text1,
        size: 40,
      ),
      shape: const CircleBorder(),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MedicineDetails()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorShades.primaryColor3,
        drawer: const DrawerWidget(),
        appBar: AppBar(
          backgroundColor: ColorShades.primaryColor1,
          // Menu button
          leading: Builder(
            builder: (ctx) {
              return IconButton(
                icon: Icon(Icons.menu_rounded, color: ColorShades.text1),
                onPressed: () {
                  Scaffold.of(ctx).openDrawer();
                },
              );
            },
          ),
          // Your Schedule
          title: Center(
              child: Text('Your schedule',
                  style: TextStyle(
                      color: ColorShades.text1,
                      fontSize: 20))),
          // Add a medicine
          actions: [addButton(context),medicineDetailsButton(context)],
        ),
        body: ListView.builder(itemBuilder: (BuildContext context, int index) {
          return const MedicineWidget();
        }
        )
        );
  }
}
