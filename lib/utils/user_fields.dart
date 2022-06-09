import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'color_shades.dart';

Text header(String desiredHeader_in) {
  return Text(desiredHeader_in,
      style: TextStyle(
        color: ColorShades.text2,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ));
}

Text content({required String desiredContent, required Color desiredColor}) {
  return Text(desiredContent,
      style: TextStyle(
        color: desiredColor,
        fontSize: 30,
      ));
}

Column userField({required String header_in, required String content_in}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      header(header_in),
      content(desiredContent: content_in, desiredColor: ColorShades.text2),
    ],
  );
}

Container contactBy({required IconData icon_in, required Function ftr}) {
  return Container(
      decoration: BoxDecoration(
          color: ColorShades.primaryColor1,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 6, color: ColorShades.text2)),
      child: IconButton(
        icon: Icon(icon_in, color: ColorShades.text1),
        onPressed: () {
          ftr();
        },
      ));
}

void openEmail() async {
  final mailtoUri = Uri(
      scheme: 'mailto',
      path: 'advitimishra@gmail.com',
      queryParameters: {'subject': '*Username\'s MediHealth schedule'});

  if (!await launchUrl(mailtoUri)) {
    throw 'Error occured while emailing';
  }
}

void openCall() async {
  final calltoUri = Uri(scheme: 'tel', path: '2694625272');
  //queryParameters: {'subject': '*Username\'s MediHealth schedule'});

  if (!await launchUrl(calltoUri)) {
    throw 'Error occured while call';
  }
}

Column userFieldIcon({
  required String header_in,
  required String content_in,
  required IconData icon_in,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      header(header_in),
      Row(
        children: [
          content(desiredContent: content_in, desiredColor: ColorShades.text2),
          const Spacer(),
          contactBy(
              icon_in: icon_in,
              ftr: () {
                header_in == 'Email: ' ? openEmail() : openCall();
              })
        ],
      )
    ],
  );
}

SizedBox verticalSpace(double desiredHeight) {
  return SizedBox(height: desiredHeight);
}

Row mandatoryHeader({required String desiredHeader}) {
  return Row(children: [
    header(desiredHeader),
    content(desiredContent: '*', desiredColor: Colors.red)
  ]);
}
