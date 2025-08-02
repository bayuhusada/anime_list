import 'package:flutter/material.dart';
import 'package:latihan_http_req/constant/colors.dart';
import '../models/anime_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AnimeDetailPage extends StatefulWidget {
  final Anime anime;

  const AnimeDetailPage({super.key, required this.anime});

  @override
  State<AnimeDetailPage> createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.anime.trailerUrl ?? '');
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.anime.title)),
      body: SingleChildScrollView(
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Anime di Atas
            Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: seconColor
              ),
              child: Image.network(
                widget.anime.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                
              ),
            ),

            // Informasi Anime
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.anime.title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Score: ${widget.anime.score ?? 'N/A'}", style: TextStyle(fontSize: 18, color: thirdColor ),),
                  Text("Episodes: ${widget.anime.episodes ?? 'N/A'}", style: TextStyle(fontSize: 20, color: seconColor )),
                  Text("Aired: ${widget.anime.aired ?? 'N/A'}"),
                  SizedBox(height: 16),
                  Text(
                    widget.anime.synopsis ?? 'No synopsis available.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            // Trailer di Bawah
            if (_controller != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: YoutubePlayer(
                  controller: _controller!,
                  showVideoProgressIndicator: true,
                ),
              ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
