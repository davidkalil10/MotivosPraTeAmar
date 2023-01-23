import 'package:flutter/material.dart';

class Historic extends StatefulWidget {
  const Historic({Key? key}) : super(key: key);

  @override
  State<Historic> createState() => _HistoricState();
}

class _HistoricState extends State<Historic> {
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
                  child: Text("Historico"),
                ), //'subtituir por arte'
              )
            ],
          ),
        ),
      ),
    );
  }
}
