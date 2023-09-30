import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/utils/app_bar.dart';
import 'package:practice_app/utils/bottom_bar.dart';
import 'package:practice_app/utils/drawer_widget.dart';
import 'package:practice_app/utils/utils_all.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MediaLibrary extends StatefulWidget {
  const MediaLibrary({Key? key, required this.mediaType}) : super(key: key);
  final int mediaType;

  @override
  _MediaLibraryState createState() => _MediaLibraryState();
}

class _MediaLibraryState extends State<MediaLibrary> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final mediaTypes = ["Messages", "Photos", "Videos", "Voice Memos"];
  final db = FirebaseFirestore.instance;
  bool hasCircle = false;
  bool isCircleOnwer = false;
  String circleId = "";
  String userId = "";
  List<dynamic> mediaEntries = [];
  List<Widget> finalEntries = [];

  Future<void> fetchMediaList() async {
    try {
      var docRef;
      // print(isCircleOnwer);

      if (isCircleOnwer) {
        docRef = await db
            .collection('media')
            .where('circleId', isEqualTo: circleId)
            .where('type', isEqualTo: widget.mediaType)
            .get();
      } else {
        docRef = await db
            .collection('media')
            .where('circleId', isEqualTo: circleId)
            .where('userId', isEqualTo: userId)
            .where('type', isEqualTo: widget.mediaType)
            .get();
      }

      final docs = docRef.docs;
      List<dynamic> list = [];
      final mappedResult =
          (docs.map((doc) => (doc.data() as Map<dynamic, dynamic>)));
      // print(mappedResult);
      // print(mappedResult.runtimeType);
      final singleDynamicList = mappedResult.toList();
      // print(singleDynamicList);
      // print(singleDynamicList.runtimeType);
      // final mapList = singleDynamicList as List<dynamic>;
      // // singleDynamicList.map((item) => (item as Map<dynamic, dynamic>));
      // print(mapList.toList());
      // print(mapList.toList().runtimeType);
      list = singleDynamicList.toList();

      setState(() {
        mediaEntries = list;
      });

      entries();
    } catch (e) {
      print("Error getting media entries: $e");
    }
  }

  Future<void> fetchData() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final uid = user!.uid;
      final docRef = db.collection('user').doc(uid);
      DocumentSnapshot doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;
      bool isCircleOwnerTemp = data['isCircleOwner'];
      String circleIdTemp = data['circleId'];
      bool hasCircleTemp = circleIdTemp != "";
      setState(() {
        hasCircle = hasCircleTemp;
        isCircleOnwer = isCircleOwnerTemp;
        circleId = circleIdTemp;
        userId = uid;
      });

      if (hasCircle) {
        fetchMediaList();
      }
    } catch (e) {
      print("Error getting user: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Widget messageEntry(String prompt, String answer, String date) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    prompt,
                    style: TextStyle(
                      color: ColorShades.primaryColor4,
                      fontSize: 24 * fontSizeMultiplier,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tahoma',
                    ),
                  ),
                  const Spacer(),
                  Text(
                    date,
                    style: TextStyle(
                      color: ColorShades.primaryColor4,
                      fontSize: 24 * fontSizeMultiplier,
                      fontFamily: 'Tahoma',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                answer,
                style: TextStyle(
                  color: ColorShades.text1,
                  fontSize: 18 * fontSizeMultiplier,
                  fontFamily: 'Tahoma',
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          decoration: BoxDecoration(
            color: ColorShades.primaryColor1,
            borderRadius: BorderRadius.circular(40),
          ),
          padding: const EdgeInsets.all(20),
        ),
      ],
    );
  }

  Future<void> getPrompt(
      String promptId, String response, String postDate) async {
    final docRef = db.collection('prompts').doc(promptId);
    DocumentSnapshot doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    final prompt = data['prompt'];
    final curEntry = messageEntry(prompt, response, postDate);
    final tempList = [...finalEntries, curEntry];

    setState(() {
      finalEntries = tempList;
    });
  }

  Widget entries() {
    for (var i = 0; i < mediaEntries.length; i++) {
      final media = mediaEntries[i];
      final response = media['textContent'];
      final postDate = media['postDate'];
      final finalDate =
          DateTime.fromMillisecondsSinceEpoch((postDate.seconds) * 1000);
      getPrompt(media['promptId'], response, finalDate.toString());
    }

    return Column(
      children: finalEntries,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: MediAppBar(importedKey: scaffoldKey),
      key: scaffoldKey,
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  mediaTypes[widget.mediaType],
                  style: TextStyle(
                    color: ColorShades.primaryColor1,
                    fontSize: 40 * fontSizeMultiplier,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Tahoma',
                  ),
                ),
                hasCircle
                    ? Column(children: finalEntries)
                    : const Text("NO CIRCLE"),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
