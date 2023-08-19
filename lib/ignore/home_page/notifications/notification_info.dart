import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:practice_app/utils/utils_all.dart';
import '../../../utils/text_to_speach.dart';

class NotificationInfo extends StatefulWidget {
  const NotificationInfo({Key? key}) : super(key: key);
  @override
  _NotificationInfo createState() => _NotificationInfo();
}

class _NotificationInfo extends State<NotificationInfo> {
  final FlutterTts flutterTts = FlutterTts();

  Center nameDosageDaysTimeStartEndDescription() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //verticalSpace(20),
          audio('Name: Ibuprofen, Dosage: 2 tablets, Additional information: swallow with water', flutterTts),
          Center(
            child: Icon(
              Icons.medication_outlined,
              color: Theme.of(context).colorScheme.onError,
              size: 100.0,
            ),
            //medicinePicIcon()
          ),
          //verticalSpace(20),
          // Name
          userField(header_in: 'Name: ', content_in: 'Ibuprofen'),
          verticalSpace(20),
          // Dosage
          userField(header_in: 'Dosage: ', content_in: '2 tablets'),
          verticalSpace(20),
          // Additional information
          userField(
              header_in: 'Additional information: ',
              content_in: 'Swallow with water'),
          Center(
            child: Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.surface,
              size: 208.0,
            ),
          ),
          verticalSpace(80)
        ],
      ),
    );

    // *******************************************************
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Card(
            elevation: 10,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Theme.of(context).colorScheme.error, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            color: Theme.of(context).colorScheme.secondary,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: nameDosageDaysTimeStartEndDescription(),
              ),
            )));
  }
}
