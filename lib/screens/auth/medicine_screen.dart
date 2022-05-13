import 'package:flutter/material.dart';
//import 'package:practice_app/screens/auth/login.dart';
import 'package:practice_app/screens/widgets/medicine_widget.dart';
import '../widgets/medicine_widget.dart';

class MedicineScreen extends StatelessWidget {
  const MedicineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(backgroundColor: Color(0xFFc70039),),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('MediHealth',
          style: TextStyle(
              fontFamily: 'Oleo Script Swash Caps', color: Colors.black)),
        leading: Builder(
          builder: (ctx){
          return IconButton(
          icon: const Icon(Icons.menu_rounded, color: Colors.grey),
          onPressed: () {
            Scaffold.of(ctx).openDrawer();
          },
          );
        },
        ),
      ),
      resizeToAvoidBottomInset: false,
     
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return const MedicineWidget();
      }),
    );
  }
}
