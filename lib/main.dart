import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:smart_home/core/app/app.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Smart Home App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const SmartHomeApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}


