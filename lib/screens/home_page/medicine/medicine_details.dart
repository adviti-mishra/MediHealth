import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:practice_app/screens/home_page/medicine/medicine_screen.dart';
import 'package:practice_app/utils/text_to_speach.dart';
import '../../../../utils/utils_all.dart';

class MedicineDetails extends StatefulWidget {
  final String uID;
  final String docID;
  final String name;
  final String dosage;
  //final List<String> days;
  final String times;
  final String startDate;
  final String endDate;
  final String moreInfo;

  const MedicineDetails({
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
  _MedicineDetailsState createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {
  final FlutterTts flutterTts = FlutterTts();

  Container medicineDetails() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: Column(
        children: [
          verticalSpace(40),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                  border: Border.all(color: Theme.of(context).colorScheme.onSecondary, width: 2)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                // constrain height of List [Email, Password]
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      audio(
                          'Name: ${widget.name}, Dosage: ${widget.dosage}, Times: ${widget.times}, Days: ,Monday, Wednesday, Friday, start date: ${widget.startDate}, end date: ${widget.endDate}, additional info: ${widget.moreInfo}',
                          flutterTts),
                      //verticalSpace(20),
                      Row(
                        children: [
                          medicinePicIcon(),
                          const Spacer(),
                          deleteButton(context, () {})
                        ],
                      ),
                      //verticalSpace(20),
                      // Name
                      userField(header_in: 'Name: ', content_in: widget.name),
                      verticalSpace(20),
                      // Dosage
                      userField(
                          header_in: 'Dosage: ', content_in: widget.dosage),
                      verticalSpace(20),
                      // Times
                      userField(header_in: 'Times: ', content_in: widget.times),
                      verticalSpace(20),
                      // Days
                      userField(
                          header_in: 'Days: ',
                          content_in: 'Monday, Wednesday, Friday'),
                      verticalSpace(20),
                      // Start date
                      userField(
                          header_in: 'Start date: ',
                          content_in: widget.startDate),
                      verticalSpace(20),
                      // End date
                      userField(
                          header_in: 'End date: ', content_in: widget.endDate),
                      verticalSpace(20),
                      // Additional information
                      userField(
                          header_in: 'Additional information: ',
                          content_in: widget.moreInfo),
                      // *******************************************************
                      verticalSpace(80),
                      // Login button
                      editButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          // Back button
          leading: Builder(
            builder: (ctx) {
              return IconButton(
                icon: Icon(Icons.arrow_back_ios_new_outlined,
                    color: Theme.of(context).colorScheme.onPrimary),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MedicineScreen(userID: widget.uID)),
                  );
                },
              );
            },
          ),
          // Medicine details
          title: FittedBox(
              fit: BoxFit.contain,
              child: Text('Medicine details',
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)))),
      body: medicineDetails(),
    );
  }
}
