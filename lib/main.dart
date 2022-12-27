import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:isproject/send.dart';

void main() async {
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDDjNXlpS2drXqUBT1B0QKTWA0Z0eik9l0",
          appId: "1:999662472616:web:aed3934e116e0937e3a19d",
          messagingSenderId: "999662472616",
          projectId: "isproject-639ec"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IS Project - Sender',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SendScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
