import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:motivosprateamar/widgets/CustomCard.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class Motivos extends StatefulWidget {
  const Motivos({Key? key}) : super(key: key);

  @override
  State<Motivos> createState() => _MotivosState();
}

class _MotivosState extends State<Motivos> {

  String _selectedPhrase = "Frase Inicial";
  String _selectedPhoto ="https://psico.online/blog/wp-content/uploads/2017/04/casal-na%CC%83o-deve-fazer-1.jpg.webp";
  bool _showcard = false;
  ScreenshotController screenshotController = ScreenshotController();
   Uint8List? _elaia = null;

  Future<void> _generateRandomPhraseAndPhoto() async {

    //sumir com o card

    setState(() {
      _showcard = false;

    });
    //Conectando ao Firestore
    final firestore = FirebaseFirestore.instance;

    //Buscando as frases e fotos armazenadas
    final phrasesSnapshot = await firestore.collection("phrases").get();
    final photosSnapshot = await firestore.collection("photos").get();
    final dadosPhotos = await firestore.collection("photos").doc("photosDoc").get();
    final dadosPhrases = await firestore.collection("phrases").doc("phrasesDoc").get();

    int? quantidadePhotos = dadosPhotos.data()?.length;
    int? quantidadePhrases = dadosPhrases.data()?.length;

    String dadoUnitario = dadosPhrases.get("2").toString(); // recupera a frase de acordo com o ID string da frase


    List<DocumentSnapshot> fotos = photosSnapshot.docs;
    DocumentSnapshot documentSnapshot = fotos[0];

    String? novo = dadosPhotos.data()?.length.toString();

    String teste =  documentSnapshot.data().toString(); //tudo
    String tamanho = teste.length.toString();

    //Gerando um número aleatório para escolher uma frase e foto
    final random = Random();
     int randomIndexPhrases = random.nextInt(quantidadePhrases!);
     int randomIndexPhotos= random.nextInt(quantidadePhotos!);

    String fraseSorteada = dadosPhrases.get(randomIndexPhrases.toString()).toString(); // recupera a frase de acordo com o ID string da frase
    String fotoSorteada = dadosPhotos.get(randomIndexPhotos.toString()).toString(); // recupera a foto de acordo com o ID string da foto

    //Atualizando a tela com a frase e foto escolhidas
    setState(() {
     _selectedPhrase = fraseSorteada;
      _selectedPhoto = fotoSorteada;
      print("fotos recuperadas: " + quantidadePhotos.toString()+ "-" + teste.toString() );
      print("Frases recuperadas: " + quantidadePhrases.toString()+ "-" );
      _showcard = true;
      //print("teste unitario: " + fraseSorteada );
    });
  }

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

   _copiarAreatransferencia () async{
    Uint8List imageBytesCaptured;
    screenshotController.capture().then((imageBytesCaptured) async{
      print(imageBytesCaptured);
      //Capture Done
      if (imageBytesCaptured != null) {
        await _requestPermission(Permission.storage);
        final directory = await getApplicationDocumentsDirectory();
        //final directory = await getExternalStorageDirectory();
       // final imagePath = await File('${directory?.path}/container_image.png').create();
        final file = File('${directory?.path}/container_image.png');
       // final file = File("/storage/emulated/0/Download"+'/container_image.png');
         await file.writeAsBytes(imageBytesCaptured);

        print("deveria ter salvo" + file.toString());

        setState(() {
          _elaia = imageBytesCaptured;
        });
      }
    }).catchError((onError) {
      print(onError);
    });

  }



  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 CustomCard(
                     imageURL: _selectedPhoto,
                     phrase: _selectedPhrase,
                     screenshotController: screenshotController,
                     saveFunction: ()=> print("salvei"),
                     copyFunction: _copiarAreatransferencia,
                     shareFunction: ()=> print("compartilhei"),
                 ),
                  Padding(
                      padding: EdgeInsets.only(top: 20)
                  ),
                //  if (_elaia!= null) Image.memory(_elaia!),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text(
                        "Motivo do Dia",
                        style: TextStyle(
                            color: Colors.white, fontSize: 20
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 24,
                          primary: Color(0xFFf99aaa),
                          padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                          )
                        //textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                      ),
                      onPressed: (){
                        _generateRandomPhraseAndPhoto();
                        //_bypassImage();

                      },
                    ),
                  ),
                ]
            ),
          ),
        )
    );
  }
}
