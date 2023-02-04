import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';

class ZoomCard extends StatelessWidget {
  final String imageURL;
  final String phrase;
  final VoidCallback deleteFunction;
  final VoidCallback downloadFunction;
  final VoidCallback shareFunction;
  final ScreenshotController screenshotController;

  ZoomCard({
    required this.imageURL,
    required this.phrase,
    required this.deleteFunction,
    required this.downloadFunction,
    required this.shareFunction,
    required this.screenshotController

  });

  @override
  Widget build(BuildContext context) {
    return  Card(
      clipBehavior: Clip.antiAlias,
      elevation: 24,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      child: Column(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Stack(
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
          ),
          Container(
            // color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Adicione a lógica para salvar aqui
                      deleteFunction();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.download),
                    onPressed: ()  {
                      downloadFunction();
                      print("passei aqui");
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
