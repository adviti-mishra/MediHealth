import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_medicine.dart';
import '../drawer_widget.dart';
import 'medicine_widget.dart';

class MedicineScreen extends StatelessWidget {
  final String userID;

  const MedicineScreen({Key? key, required this.userID}) : super(key: key);

  RawMaterialButton addButton(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        Icons.add_circle_outline,
        color: Theme.of(context).colorScheme.primary,
        size: 60,
      ),
      shape: const CircleBorder(),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddMedicine()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onError,
        // Menu button
        leading: Builder(
          builder: (ctx) {
            return IconButton(
              icon: Icon(Icons.menu_rounded,
                  color: Theme.of(context).colorScheme.onPrimary),
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              },
            );
          },
        ),
        // Your Schedule
        title: FittedBox(
            fit: BoxFit.contain,
            child: Text('Your schedule',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20))),
        // Add a medicine
        actions: [addButton(context)],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(userID)
              .collection('medicines')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MedicineWidget(
                          uID: userID,
                          docID: snapshot.data!.docs[index].id.toString(),
                          name: snapshot.data!.docs[index]['name'],
                          dosage: snapshot.data!.docs[index]['dosage'],
                          //days: snapshot.data!.docs[index]['days'],
                          times: snapshot.data!.docs[index]['times'],
                          startDate: snapshot.data!.docs[index]['startDate'],
                          endDate: snapshot.data!.docs[index]['endDate'],
                          moreInfo: snapshot.data!.docs[index]['moreInfo']);
                    });
              }
            }
            return Center(
              child: Text('No medicines have been added yet',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground)),
            );
          }),
    );
  }
}
