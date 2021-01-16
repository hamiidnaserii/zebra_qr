import 'dart:ui';

import 'file:///C:/Users/Ech%20Dev/AndroidStudioProjects/ech_flutter/lib/src/MainSrc.dart';
import 'package:ech_flutter/pages/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Zebra Qr',
    theme: ThemeData(
      primaryColor:Colors.lightBlue,
    ),
    debugShowCheckedModeBanner: false,
    home: MyFadeTest(),
  ));
}


