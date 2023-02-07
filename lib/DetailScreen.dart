import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:motivosprateamar/widgets/ZoomCard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';


class DetailScreen extends StatefulWidget {
  DocumentSnapshot imageAndText;
  DetailScreen({required this.imageAndText});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DocumentSnapshot _imageAndText;
  ScreenshotController screenshotController = ScreenshotController();

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  _salvarGaleria () async{
    Uint8List imageBytesCaptured;
    screenshotController.capture().then((imageBytesCaptured) async{
      print(imageBytesCaptured);
      //Capture Done
      if (imageBytesCaptured != null) {
        await _requestPermission(Permission.storage);
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory?.path}/container_image.png');
        await file.writeAsBytes(imageBytesCaptured);

        final path = await ImageGallerySaver.saveImage(imageBytesCaptured); //vai carai

        print("deveria ter salvo" + file.toString());
        print("Image saved to gallery: $path");

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
            content: Text(
              "Download para galeria sucesso!",
              style: GoogleFonts.gloriaHallelujah(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )));

        setState(() {
        });
      }
    }).catchError((onError) {
      print(onError);
    });

  }


  _compartilhar () async{
    Uint8List imageBytesCaptured;
    screenshotController.capture().then((imageBytesCaptured) async{
      print(imageBytesCaptured);
      //Capture Done
      if (imageBytesCaptured != null) {
        await _requestPermission(Permission.storage);
        final directory = await getTemporaryDirectory();
      //  final file = File('${directory?.path}/image.png');
        final path = '${directory?.path}/image.png';
      //  await file.writeAsBytes(imageBytesCaptured);
        File(path).writeAsBytesSync(imageBytesCaptured);

        await Share.shareFiles([path], text: "Te amo pra sempre <3");

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
            content: Text(
              "Compartilhado com sucesso!",
              style: GoogleFonts.gloriaHallelujah(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )));

        setState(() {
        });
      }
    }).catchError((onError) {
      print(onError);
    });

  }

  _deletarFirebase() async {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Porque vc ta fazendo isso com a gente cara? 🥺'),
          actions: [
            TextButton(
              child: Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sim'),
              onPressed: () async {
                Navigator.of(context).pop();
                await FirebaseFirestore.instance
                    .collection("Photos_and_Phrases")
                    .doc(_imageAndText.id)
                    .delete();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(
                    content: Text(
                      "Deletado com sucesso!",
                      style: GoogleFonts.gloriaHallelujah(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )));
              },
            ),
          ],
        );
      },
    );


}


  @override
  void initState() {
    super.initState();
    _imageAndText = widget.imageAndText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFffcdd4),
        body: Container(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ZoomCard(
                        imageURL: _imageAndText["photo"],
                        phrase: _imageAndText["phrase"],
                        screenshotController: screenshotController,
                        deleteFunction: _deletarFirebase,
                        downloadFunction: _salvarGaleria,
                        shareFunction: _compartilhar
                      )
                    ]
                ),
              ),
            )
        )
    );
  }
}

