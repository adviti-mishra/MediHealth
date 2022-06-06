import 'package:flutter/material.dart';
import '../../../../utils/utils_all.dart';

class MedicineDetails extends StatefulWidget {
  const MedicineDetails({Key? key}) : super(key: key);

  @override
  _MedicineDetailsState createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {


  Container medicineDetails() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorShades.primaryColor3,
      ),
      child: Column(
        children: [
          verticalSpace(40),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: ColorShades.primaryColor2,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                  border: Border.all(color: ColorShades.text2, width: 2)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                // constrain height of List [Email, Password]
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //verticalSpace(20),
                      Row(
                        children: [
                          medicinePicIcon(),
                          const Spacer(),
                          deleteButton(context)
                        ],
                      ),
                      //verticalSpace(20),
                      // Name
                      userField(header_in: 'Name: ', content_in: 'Ibuprofin'),
                      verticalSpace(20),
                      // Dosage
                      userField(header_in: 'Dosage: ', content_in: '20ml'),
                      verticalSpace(20),
                      // Times
                      userField(
                          header_in: 'Times: ', content_in: '1PM, 6PM, 10PM'),
                      verticalSpace(20),
                      // Days
                      userField(
                          header_in: 'Days: ',
                          content_in: 'Monday, Wednesday, Friday'),
                      verticalSpace(20),
                      // Start date
                      userField(
                          header_in: 'Start date: ',
                          content_in: '14th June, 2022'),
                      verticalSpace(20),
                      // End date
                      userField(
                          header_in: 'End date: ',
                          content_in: '15th July, 2022'),
                      verticalSpace(20),
                      // Additional information
                      userField(
                          header_in: 'Additional information: ',
                          content_in: 'Swallow immediately.'),
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
      backgroundColor: ColorShades.primaryColor3,
      appBar: AppBar(
          backgroundColor: ColorShades.primaryColor1,
          // Back button
          leading: Builder(
            builder: (ctx) {
              return IconButton(
                icon: Icon(Icons.arrow_back_ios_new_outlined,
                    color: ColorShades.text1),
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
              );
            },
          ),
          // Medicine details
          title: Center(
              child: Text('Medicine details',
                  style: TextStyle(color: ColorShades.text1, fontSize: 40)))),
      body: medicineDetails(),
    );
  }
}
