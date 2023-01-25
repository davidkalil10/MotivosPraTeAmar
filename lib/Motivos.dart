import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:motivosprateamar/widgets/CustomCard.dart';

class Motivos extends StatefulWidget {
  const Motivos({Key? key}) : super(key: key);

  @override
  State<Motivos> createState() => _MotivosState();
}

class _MotivosState extends State<Motivos> {

  String _selectedPhrase = "Frase Inicial";
  String _selectedPhoto ="https://psico.online/blog/wp-content/uploads/2017/04/casal-na%CC%83o-deve-fazer-1.jpg.webp";
  bool _showcard = false;

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
                     saveFunction: ()=> print("salvei"),
                     copyFunction: ()=> print("copiei"),
                     shareFunction: ()=> print("compartilhei"),
                 ),
                  Padding(
                      padding: EdgeInsets.only(top: 20)
                  ),
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
