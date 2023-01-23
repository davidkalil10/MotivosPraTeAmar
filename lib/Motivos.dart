import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Motivos extends StatefulWidget {
  const Motivos({Key? key}) : super(key: key);

  @override
  State<Motivos> createState() => _MotivosState();
}

class _MotivosState extends State<Motivos> {

  String _selectedPhrase = "Frase Inicial";
  String _selectedPhoto ="https://psico.online/blog/wp-content/uploads/2017/04/casal-na%CC%83o-deve-fazer-1.jpg.webp";

  Future<void> _generateRandomPhraseAndPhoto() async {
    //Conectando ao Firestore
    final firestore = FirebaseFirestore.instance;

    //Buscando as frases e fotos armazenadas
    final phrasesSnapshot = await firestore.collection("phrases").get();
    final photosSnapshot = await firestore.collection("photos").get();

    //Convertendo os dados buscados em listas
    //final List phrases = phrasesSnapshot.docs.map((doc) => doc.data.["phrase"]).toList();
    //final List photos = photosSnapshot.docs.map((doc) => doc.data["photo"]).toList();

    //Gerando um número aleatório para escolher uma frase e foto
    final random = Random();
   // final int randomIndex = random.nextInt(phrases.length);

    //Atualizando a tela com a frase e foto escolhidas
    setState(() {
      //_selectedPhrase = phrases[randomIndex];
    //  _selectedPhoto = photos[randomIndex];
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
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 64, bottom: 32),
                  child: Text("Motivos: " +_selectedPhrase), //'subtituir por arte'
                ),
              ),
              Center(
                child: Image.network(_selectedPhoto),
              ),
              ElevatedButton(
                child: Text(
                  "Motivo do Dia",
                  style: TextStyle(
                      color: Colors.white, fontSize: 20
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFFf99aaa),
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)
                    )
                  //textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                ),
                onPressed: (){},
              ),
            ]
           ),
      ),
      )
    );
  }
}
