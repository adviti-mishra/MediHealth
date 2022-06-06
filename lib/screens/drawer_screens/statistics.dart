import 'package:flutter/material.dart';
import 'package:practice_app/utils/utils_all.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);
  @override
  _Statistics createState() => _Statistics();
}

class _Statistics extends State<Statistics> {
  Column statisticsContent() {
    return Column(
      children: const [
        Text('1. Bar graph of medicine time delay vs medicine'),
        Text('Name of medicine usually haven late : '),
        Text('Suggestion : '),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorShades.primaryColor1,
        title: Center(
            child: Text('Statistics on Medicine usage',
                style: TextStyle(
                    color: ColorShades.text1,
                    fontSize: 40))),
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
      ),
      body: statisticsContent(),
    );
  }
}
