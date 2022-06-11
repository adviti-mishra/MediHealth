import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/utils/utils_all.dart';
import 'package:weekday_selector/weekday_selector.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({Key? key}) : super(key: key);
  @override
  _AddMedicine createState() => _AddMedicine();
}

class _AddMedicine extends State<AddMedicine> {
  // initializing TextEditingControllers
  final TextEditingController _medicineNameTextController =
      TextEditingController();
  final TextEditingController _medicineDosageTextController =
      TextEditingController();
  final TextEditingController _medicineDaysTextController =
      TextEditingController(text: 'Choose days');
  final TextEditingController _medicineTimeofDayTextController =
      TextEditingController(text: 'Choose time of day');

  final TextEditingController _startDateTextController =
      TextEditingController(text: 'Choose start date');
  final TextEditingController _endDateTextController =
      TextEditingController(text: 'Choose end date');
  final TextEditingController _medicineDescriptionTextController =
      TextEditingController();

  final _uploadMedicineFormKey = GlobalKey<FormState>();

  DateTime? startDate;
  DateTime? endDate;

  // We start with all days not selected.
  List<bool> values = List.filled(7, false);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  // deconstructor : TextEditingControllers
  void dispose() {
    super.dispose();
    _medicineNameTextController.dispose();
    _medicineDaysTextController.dispose();
    _medicineTimeofDayTextController.dispose();
    _medicineDosageTextController.dispose();
    _startDateTextController.dispose();
    _endDateTextController.dispose();
    _medicineDescriptionTextController.dispose();
  }

  void _uploadTaskForm() {
    final User? user = _auth.currentUser;
    final _uid = user!.uid;
    final isValid = _uploadMedicineFormKey.currentState!.validate();
    if (isValid) {
        FirebaseFirestore.instance.collection('user').doc(_uid).collection('medicines').doc().set({
          'id': _uid,
          'name': _medicineNameTextController.text,
          'dosage': _medicineDosageTextController.text,
          'days': values, // true - day selected
          'startDate': _startDateTextController.text,
          'endDate': _endDateTextController.text,
          'moreInfo':_medicineDescriptionTextController.text
        });
      //print('it is valid');
    } else {
      //print('it is not valid');
    }
  }

  InkWell fieldValidation(
      {required String valueKey,
      required TextEditingController controller,
      required bool enabled,
      required Function ftor,
      required int maxlength}) {
    return InkWell(
      onTap: () {
        ftor();
      },
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        key: ValueKey(valueKey),
        maxLines: valueKey == 'medicineDescription' ? 3 : 1,
        maxLength: maxlength,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please fill this field";
          } else {
            return null;
          }
        },
        style: TextStyle(color: ColorShades.text2),
        decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 4.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          fillColor: ColorShades.text1,
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }

  Form nameDosageDaysTimeStartEndDescription() {
    return Form(
      key: _uploadMedicineFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name:
          medicineNameField(),
          // BLANK LINE
          verticalSpace(20),
          // Dosage:
          dosageField(),
          // BLANK LINE
          verticalSpace(20),
          // Days:
          daysField(),
          // BLANK LINE
          verticalSpace(20),
          // Times of the day:
          timesofDayField(),
          // BLANK LINE
          verticalSpace(20),
          Text("Medication duration: ",
              style: TextStyle(
                color: ColorShades.text2,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
          // Start date :              End date:
          Row(
            children: [
              Expanded(child: startDateField()),
              //const SizedBox(
              // width: 50,
              //),
              Expanded(
                child: endDateField(),
              ),
            ],
          ),
          // BLANK LINE
          verticalSpace(20),
          // More info:
          descriptionField(),
          // BLANK LINE
          verticalSpace(20),
          // Add medicine BUTTON
          uploadMedicineButton(),
        ],
      ),
    );
  }

  Column medicineNameField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: 'Name: ')),
      fieldValidation(
          valueKey: 'medicineName',
          controller: _medicineNameTextController,
          enabled: true,
          ftor: () {},
          maxlength: 100)
    ]);
  }

  Column dosageField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: 'Dosage: ')),
      fieldValidation(
          valueKey: 'medicineDosage',
          controller: _medicineDosageTextController,
          enabled: true,
          ftor: () {},
          maxlength: 100)
    ]);
  }

  Column daysField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: 'Days of intake ')),
      WeekdaySelectorTheme(
        data: WeekdaySelectorThemeData(
          
          color: Colors.black,
          fillColor: ColorShades.text1,
          disabledFillColor: ColorShades.primaryColor2,
          selectedFillColor: ColorShades.primaryColor1,
        ),
        child: WeekdaySelector(
          onChanged: (int day) {
            setState(() {
              // Use module % 7 as Sunday's index in the array is 0 and
              final index = day % 7;
              // We "flip" the value
              values[index] = !values[index];
            });
          },
          values: values,
        ),
      )
    ]);
  }

  Column timesofDayField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: 'Times of day ')),
      fieldValidation(
          valueKey: 'medicineTimesofDay',
          controller: _medicineTimeofDayTextController,
          enabled: false,
          ftor: () {},
          maxlength: 100)
    ]);
  }

  Column startDateField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: 'Start date ')),
      fieldValidation(
          valueKey: 'medicineStartDate',
          controller: _startDateTextController,
          enabled: false,
          ftor: () {
            pickStartDateDialog();
          },
          maxlength: 100)
    ]);
  }

  void pickStartDateDialog() async {
    startDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 0)),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                  primary: ColorShades.primaryColor1, // header background color
                  onPrimary: ColorShades.text1, // header text color
                  onSurface: ColorShades.text2 // body text color
                  ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: ColorShades.primaryColor1, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });
    if (startDate != null) {
      setState(() {
        _startDateTextController.text = formattedDate(startDate);
      });
    }
  }

  Column endDateField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: 'End date ')),
      fieldValidation(
          valueKey: 'medicineEndDate',
          controller: _endDateTextController,
          enabled: false,
          ftor: () {
            pickEndDateDialog();
          },
          maxlength: 100)
    ]);
  }

  void pickEndDateDialog() async {
    endDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 0)),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                  primary: ColorShades.primaryColor1, // header background color
                  onPrimary: ColorShades.text1, // header text color
                  onSurface: ColorShades.text2 // body text color
                  ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: ColorShades.primaryColor1, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });
    //print('End date picked$endDate');
    if (endDate != null) {
      setState(() {
        _endDateTextController.text = formattedDate(endDate);
      });
    }
  }

  Column descriptionField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: 'More information ')),
      fieldValidation(
          valueKey: 'medicineDescription',
          controller: _medicineDescriptionTextController,
          enabled: true,
          ftor: () {},
          maxlength: 250)
    ]);
  }

  MaterialButton uploadMedicineButton() {
    return MaterialButton(
      onPressed: _uploadTaskForm,
      color: ColorShades.primaryColor1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add medicine ',
              style: TextStyle(
                color: ColorShades.text1,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.upload_file_outlined,
              color: ColorShades.text1,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorShades.primaryColor3,
      appBar: AppBar(
        backgroundColor: ColorShades.primaryColor1,
        title: FittedBox(
                fit: BoxFit.contain,
                child: Text('Add a medicine',
                style: TextStyle(color: ColorShades.text1))),
        leading: Builder(
          builder: (ctx) {
            return IconButton(
              icon: Icon(Icons.arrow_back_ios_new_sharp,
                  color: ColorShades.text1),
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
            );
          },
        ),
      ),
      body: Card(
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        color: ColorShades.primaryColor2,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Medicine Information
            const Padding(
                padding: EdgeInsets.only(top: 50, right: 10, left: 10),
                child: Align(
                    alignment: Alignment.center,
                    child: Text('Medicine Information',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 40)))),
            const SizedBox(height: 10),
            //__________________________
            const Divider(thickness: 1),
            // <body>
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: nameDosageDaysTimeStartEndDescription(),
            )
          ]),
        ),
      ),
    );
  }
}
