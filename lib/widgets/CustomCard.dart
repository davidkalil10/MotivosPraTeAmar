import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {

  final String imageURL;
  final String phrase;
  final VoidCallback saveFunction;
  final VoidCallback copyFunction;
  final VoidCallback shareFunction;


  CustomCard({
      required this.imageURL,
      required this.phrase,
      required this.saveFunction,
      required this.copyFunction,
      required this.shareFunction
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 24,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                imageURL,fit: BoxFit.fill,
              ),
              Text(
                "\"" +phrase+ "\"",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24
                ),
              )
            ],
          ),
          Container(
            // color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      // Adicione a lógica para salvar aqui
                      saveFunction();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.content_copy),
                    onPressed: () {
                      // Adicione a lógica para copiar aqui
                      copyFunction();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      // Adicione a lógica para compartilhar aqui
                      shareFunction();
                    },
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
}
