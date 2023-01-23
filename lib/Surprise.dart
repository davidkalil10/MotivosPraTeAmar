import 'package:flutter/material.dart';

class Surprise extends StatefulWidget {
  const Surprise({Key? key}) : super(key: key);

  @override
  State<Surprise> createState() => _SurpriseState();
}

class _SurpriseState extends State<Surprise> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 64, bottom: 32),
                child: Container(
                  child: Text("Surprise"),
                ), //'subtituir por arte'
              )
            ],
          ),
        ),
      ),
    );
  }
}
