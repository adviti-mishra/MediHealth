import 'package:flutter/material.dart';
//import 'package:practice_app/screens/auth/login.dart';
import 'widgets/drawer_widget.dart';
import 'widgets/medicine_widget.dart';
import '../../constants/color_shades.dart';

class MedicineScreen extends StatelessWidget {
  const MedicineScreen({Key? key}) : super(key: key);

  RawMaterialButton addButton() {
    return RawMaterialButton(
        child: Icon(
          Icons.cancel_outlined,
          color: ColorShades.primaryColor1,
          size: 40,
        ),
        shape: const CircleBorder(),
        onPressed: () {},
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
          backgroundColor: ColorShades.primaryColor1,
          title: Center(
              child: Text('Your schedule',
                  style: TextStyle(
                      fontFamily: 'Oleo Script Swash Caps',
                      color: ColorShades.text1,
                      fontSize: 40))),
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
        ),
      body: 

       /* Row(children: [
          const Text('insert search bar here'),
          const SizedBox(width: 200,),
          addButton(),
        ],),
        */
        ListView.builder(itemBuilder: (BuildContext context, int index) {
        return const MedicineWidget();
         })
    

      );

  }
}
