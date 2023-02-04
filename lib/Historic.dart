import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motivosprateamar/DetailScreen.dart';

class Historic extends StatefulWidget {
  const Historic({Key? key}) : super(key: key);

  @override
  State<Historic> createState() => _HistoricState();
}


class _HistoricState extends State<Historic> {

  late StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();

    // Adiciona o listener ao banco de dados
    _streamSubscription = FirebaseFirestore.instance
        .collection("Photos_and_Phrases")
        .snapshots()
        .listen((event) {
      // Reconstrói a tela sempre que houver mudanças no banco de dados
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Remove o listener do banco de dados ao sair da tela
    _streamSubscription.cancel();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Photos_and_Phrases")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<DocumentSnapshot> imagesAndTexts = snapshot.data!.docs;

        return ListView.builder(
          itemCount: imagesAndTexts.length,
          itemBuilder: (context, index) {
            DocumentSnapshot imageAndText = imagesAndTexts[index];

            return InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      imageAndText: imagesAndTexts[index]
                    )
                  )
                );
              },
              child: Card(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Image.network(
                        imageAndText["photo"],
                      ),
                    ),
                    Center(
                      child: Text(
                        imageAndText["phrase"],
                        style: GoogleFonts.gloriaHallelujah(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
