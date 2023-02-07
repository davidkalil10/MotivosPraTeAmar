import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:motivosprateamar/Home.dart';
import 'package:motivosprateamar/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    title: "Motivos Pra Te Amar",
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}


