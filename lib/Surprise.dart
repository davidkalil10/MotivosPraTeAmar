import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Surprise extends StatefulWidget {
  const Surprise({Key? key}) : super(key: key);

  @override
  State<Surprise> createState() => _SurpriseState();
}

class _SurpriseState extends State<Surprise> {

  late VideoPlayerController _controller;
  String videoUrl = "";

  Future<void> _getSurprise()async {

    final firestore = FirebaseFirestore.instance;

    //Buscando url do video
    final urlSnapshot = await firestore.collection("surprise").doc("URL").get();

    String url = urlSnapshot.get("URL").toString(); // recupera a URL do video

    print("url recuperada: " + url);

    setState(() {
      videoUrl = url;
    });

    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });

  }



  @override
  void initState() {
    _getSurprise();

     _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {
          print("inicializado:" + _controller.value.isInitialized.toString());
        });
      });

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: Center(
                  child: _controller.value.isInitialized
                      ? Column(
                        children: [
                          AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                          Slider(
                            value: _controller.value.position.inSeconds.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                _controller
                                  ..seekTo(Duration(seconds: value.toInt()));
                              });
                            },
                            min: 0,
                            max: _controller.value.duration.inSeconds.toDouble(),
                          ),
                          Text("${_controller.value.position.inSeconds} / ${_controller.value.duration.inSeconds}"),
                        ],
                      )
                      : Container(
                    child: Text("Recuperando"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
