import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';


class CustomCard extends StatelessWidget {

  final String imageURL;
  final String phrase;
  final VoidCallback saveFunction;
  final VoidCallback downloadFunction;
  final VoidCallback shareFunction;
  final ScreenshotController screenshotController;


  CustomCard({
      required this.imageURL,
      required this.phrase,
      required this.saveFunction,
      required this.downloadFunction,
      required this.shareFunction,
      required this.screenshotController

  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  style: GoogleFonts.gloriaHallelujah(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
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
                    icon: Icon(Icons.save),
                    onPressed: () {
                      // Adicione a lógica para salvar aqui
                      saveFunction();
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
