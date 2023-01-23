import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:motivosprateamar/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "Motivos Pra Te Amar",
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}


